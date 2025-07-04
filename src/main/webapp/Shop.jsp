<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Shop Page</title>

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <!-- Google Fonts Roboto -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" />
  <!-- MDB -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" />
  
  <!-- Custom styles -->
  <link href="css/style.css" rel="stylesheet" type="text/css"/> 
  <link href="css/product-cards.css" rel="stylesheet" type="text/css"/>

<style>
.sort-option {
    transition: all 0.3s ease;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
}

.sort-option:hover {
    background-color: #f8f9fa;
    transform: translateY(-2px);
}

.sort-option.active {
    background-color: #007bff;
    color: white;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.sort-option input[type="radio"] {
    display: none;
}

.sort-option label {
    cursor: pointer;
    margin: 0;
    padding: 5px 10px;
    display: inline-block;
    transition: all 0.3s ease;
}

.sort-label {
    padding: 5px 10px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.sort-label.active {
    background-color: #007bff;
    color: white;
}

input[type="radio"]:checked + .sort-label {
    background-color: #007bff;
    color: white;
}
</style>

</head>

<body class="skin-light" onload="loadAmountCart(); initializeShopPage();">

  <!--Main Navigation-->
  <header>

 	 <jsp:include page="Menu.jsp"></jsp:include>

  </header>
  <!--Main Navigation-->

  <!--Main layout-->
  <main>
    <div class="container">

      <!-- Category Selection Banner -->
      <c:if test="${selectedCid != null}">
        <div class="row mb-4">
          <div class="col-12">
                            <div class="alert alert-info d-flex align-items-center" style="border-radius: 10px; border: none; background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%); color: white;">
              <i class="fas fa-filter fa-lg mr-3"></i>
              <div class="flex-grow-1">
                <h5 class="mb-1">Đang xem sản phẩm theo danh mục</h5>
                <c:forEach items="${listCC}" var="category">
                  <c:if test="${category.cid == selectedCid}">
                    <p class="mb-0"><strong>"${category.cname}"</strong></p>
                  </c:if>
                </c:forEach>
              </div>
              <a href="shop" class="btn btn-light btn-sm ml-3">
                <i class="fas fa-times mr-1"></i>
                Xem tất cả
              </a>
            </div>
          </div>
        </div>
      </c:if>

      <!--Grid row-->
      <div class="row mt-5">

        <!--Grid column-->
        <div class="col-md-4 mb-4">

          <!-- Section: Sidebar -->
          <section>

            <!-- Section: Categories -->
            <section>

              <h5>Categories</h5>

              <div class="text-muted small text-uppercase mb-5">
			<c:forEach items="${listCC}" var="o">
                <p class="mb-3"><a href="#" onclick="load('${o.cid}'); return false;" class="card-link-secondary">${o.cname}</a></p>
              </c:forEach>
              </div>

            </section>
            <!-- Section: Categories -->

            <!-- Section: Filters -->
            <section>

              <h5 class="pt-2 mb-4">Filters</h5>

              <section class="mb-4">

                <!-- Lấy từ khóa tìm kiếm từ request parameter -->
                <% 
                String searchKeyword = "";
                if (request.getAttribute("txtS") != null) {
                    searchKeyword = (String) request.getAttribute("txtS");
                } else if (request.getParameter("search") != null) {
                    searchKeyword = request.getParameter("search");
                }
                %>

                <!-- Hiển thị từ khóa trong ô search -->
                <div class="form-group">
                  <input type="text" class="form-control" id="searchInput" name="txt" placeholder="Enter keyword..." value="${searchKeyword}" oninput="applyFilters()">
                </div>

                <script>
                let searchTimeout;
                let currentSearchText = '';
                
                function searchByName(param) {
                    clearTimeout(searchTimeout);
                    const searchInput = document.getElementById('searchInput');
                    const suggestionsDiv = document.getElementById('searchSuggestions');
                    
                    searchTimeout = setTimeout(() => {
                        const txtSearch = searchInput.value;
                        currentSearchText = txtSearch;
                        
                        // Clear category selection when searching
                        window.currentCategoryId = null;
                        
                        if (txtSearch.length > 0) {
                            $.ajax({
                                url: "/WebsiteBanSua/searchAjaxShop",
                                type: "get",
                                data: {
                                    txt: txtSearch
                                },
                                success: function (data) {
                                    var row = document.getElementById("content");
                                    row.innerHTML = data;
                                    
                                    // Show suggestions based on search results
                                    const products = $(data).find('.product-name');
                                    if (products.length > 0) {
                                        suggestionsDiv.innerHTML = '';
                                        products.each(function() {
                                            const suggestion = document.createElement('a');
                                            suggestion.className = 'dropdown-item';
                                            suggestion.href = '#';
                                            suggestion.textContent = $(this).text();
                                            suggestion.onclick = function(e) {
                                                e.preventDefault();
                                                searchInput.value = $(this).text();
                                                searchByName({value: $(this).text()});
                                                suggestionsDiv.style.display = 'none';
                                            };
                                            suggestionsDiv.appendChild(suggestion);
                                        });
                                        suggestionsDiv.style.display = 'block';
                                    } else {
                                        suggestionsDiv.style.display = 'none';
                                    }
                                },
                                error: function (xhr) {
                                    console.error('Search failed:', xhr);
                                }
                            });
                        } else {
                            suggestionsDiv.style.display = 'none';
                            // If search is cleared, show all products
                            loadAllProducts();
                        }
                    }, 300);
                }

                function loadAllProducts() {
                    $.ajax({
                        url: "/WebsiteBanSua/loadAllProducts",
                        type: "get",
                        success: function (data) {
                            var row = document.getElementById("content");
                            row.innerHTML = data;
                        }
                    });
                }

                function load(cateid) {
                    window.currentCategoryId = cateid;
                    // Clear search input when category is selected
                    document.getElementById('searchInput').value = '';
                    currentSearchText = '';
                    
                    $.ajax({
                        url: "/WebsiteBanSua/categoryShop",
                        type: "get",
                        data: {
                            cid: cateid
                        },
                        success: function (responseData) {
                            document.getElementById("content").innerHTML = responseData;
                        }
                    });
                }
                </script>

              </section>

          
              <!-- Section: Price -->
              <section class="mb-4">

                <h6 class="font-weight-bold mb-3">Giá</h6>

                <div class="form-check pl-0 mb-3">
                  <input onchange="applyFilters(false)" type="radio" class="form-check-input" id="priceDefault" name="priceSort" value="" <c:if test="${empty sortType || sortType == 'default' || sortType == 'az' || sortType == 'za' || sortType == 'new'}">checked</c:if>>
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceDefault">Mặc định</label>
                </div>
                <div class="form-check pl-0 mb-3">
                  <input onchange="applyFilters(false)" type="radio" class="form-check-input" id="priceAsc" name="priceSort" value="price_asc" <c:if test="${sortType == 'price_asc'}">checked</c:if>>
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceAsc">Giá: Thấp đến Cao</label>
                </div>
                <div class="form-check pl-0 mb-3">
                  <input onchange="applyFilters(false)" type="radio" class="form-check-input" id="priceDesc" name="priceSort" value="price_desc" <c:if test="${sortType == 'price_desc'}">checked</c:if>>
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceDesc">Giá: Cao đến Thấp</label>
                </div>
                <form onsubmit="event.preventDefault(); applyFilters();">
                  <div class="d-flex align-items-center mt-4 pb-1">
                    <div class="md-form md-outline my-0">
                      <input id="priceMin" type="number" class="form-control mb-0" value="${priceMin}">
                      <label for="priceMin">VNĐ Thấp nhất</label>
                    </div>
                    <p class="px-2 mb-0 text-muted"> - </p>
                    <div class="md-form md-outline my-0">
                      <input id="priceMax" type="number" class="form-control mb-0" value="${priceMax}">
                      <label for="priceMax">VNĐ Cao nhất</label>
                    </div>
                  </div>
                   <button type="submit" class="btn btn-primary btn-sm btn-block mt-2">Lọc theo giá</button>
                </form>

              </section>
              <!-- Section: Price -->

            </section>
            <!-- Section: Filters -->

          </section>
          <!-- Section: Sidebar -->

        </div>
        <!--Grid column-->

        <!--Grid column-->
        <div class="col-md-8 mb-4">

          <!-- Section: Block Content -->
          <section class="mb-3">

            <div class="row d-flex justify-content-around align-items-center">
              <div class="col-12 col-md-8 text-center text-md-left">
                <form id="sortForm" class="d-flex align-items-center">
                  <label class="mr-2 font-weight-bold">Xếp theo:</label>
                  <input type="radio" id="sortDefault" name="sortOption" value="default" <c:if test="${empty sortType || sortType == 'default'}">checked</c:if> class="ml-2 mr-1" onclick="applyFilters()">
                  <label for="sortDefault" class="mr-3 sort-label">Mặc định</label>
                  <input type="radio" id="sortAZ" name="sortOption" value="az" <c:if test="${sortType == 'az'}">checked</c:if> class="mr-1" onclick="applyFilters()">
                  <label for="sortAZ" class="mr-3 sort-label">Tên A-Z</label>
                  <input type="radio" id="sortZA" name="sortOption" value="za" <c:if test="${sortType == 'za'}">checked</c:if> class="mr-1" onclick="applyFilters()">
                  <label for="sortZA" class="mr-3 sort-label">Tên Z-A</label>
                  <input type="radio" id="sortNew" name="sortOption" value="new" <c:if test="${sortType == 'new'}">checked</c:if> class="mr-1" onclick="applyFilters()">
                  <label for="sortNew" class="sort-label">Hàng mới</label>
                </form>
              </div>
            </div>
            <script>
            function sortProducts(type) {
                var searchText = document.getElementById('searchInput').value;
                var cid = window.currentCategoryId;
                let url = '';
                let data = { txt: searchText, cid: cid };
                if(type === 'default') {
                    loadAllProducts();
                    return;
                } else if(type === 'az') {
                    url = '/WebsiteBanSua/sortByNameAZ';
                } else if(type === 'za') {
                    url = '/WebsiteBanSua/sortByNameZA';
                } else if(type === 'new') {
                    url = '/WebsiteBanSua/sortByNewest';
                }
                $.ajax({
                    url: url,
                    type: 'get',
                    data: data,
                    success: function(data) {
                        var row = document.getElementById('content');
                        row.innerHTML = data;
                    }
                });
            }
            </script>

          </section>
          <!-- Section: Block Content -->

          <!--Section: Block Content-->
          <section>

            <!-- Grid row -->
            <div class="row" id="content">
				<jsp:include page="ProductGrid.jsp" />
            </div>
            <!-- Grid row -->
          </section>
          <!--Section: Block Content-->

    </div>
  </main>
  <!--Main layout-->

  <!-- Footer -->
  

   <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <!-- Footer -->



  <!-- SCRIPTS -->
  <!-- MDB -->
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.js"></script>
  <!-- Custom scripts -->
  <script>
    let filterTimeout;

    function applyFilters(useTimeout = true) {
        if (useTimeout) {
            clearTimeout(filterTimeout);
            filterTimeout = setTimeout(() => {
                performAjaxFilter();
            }, 500); // Wait 500ms before sending request
        } else {
            performAjaxFilter();
        }
    }

    function performAjaxFilter() {
        var cid = document.querySelector('.category-link.active')?.dataset.cid || '${selectedCid}' || '';
        var searchKeyword = document.getElementById('searchInput').value;
        var priceMin = document.getElementById('priceMin').value;
        var priceMax = document.getElementById('priceMax').value;
        
        // Determine sort type from both radio groups
        var sortType = document.querySelector('input[name="priceSort"]:checked')?.value || '';
        if (!sortType) {
            sortType = document.querySelector('input[name="sortOption"]:checked')?.value || 'default';
        }


        $.ajax({
            url: "shop", // All requests go to ShopControl
            type: "get",
            data: {
                cid: cid,
                search: searchKeyword,
                sort: sortType,
                priceMin: priceMin,
                priceMax: priceMax
            },
            beforeSend: function(xhr) {
                // Set header for AJAX request detection in servlet
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            },
            success: function(data) {
                document.getElementById("content").innerHTML = data;
                // Update URL without reloading page
                updateUrl(cid, searchKeyword, sortType, priceMin, priceMax);
            },
            error: function(xhr) {
                console.error("An error occurred during filtering: ", xhr);
            }
        });
    }

    function updateUrl(cid, search, sort, priceMin, priceMax) {
        var newUrl = window.location.pathname + '?';
        var params = [];
        if (cid) params.push('cid=' + cid);
        if (search) params.push('search=' + search);
        if (sort && sort !== 'default') params.push('sort=' + sort);
        if (priceMin) params.push('priceMin=' + priceMin);
        if (priceMax) params.push('priceMax=' + priceMax);

        history.pushState(null, '', newUrl + params.join('&'));
    }

    document.querySelectorAll('.category-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelectorAll('.category-link').forEach(el => el.classList.remove('active'));
            this.classList.add('active');
            applyFilters(false);
        });
    });

    function loadAmountCart(){
    	 $.ajax({
             url: "/WebsiteBanSua/loadAllAmountCart",
             type: "get", //send it through get method
             data: {
                 
             },
             success: function (responseData) {
                 document.getElementById("amountCart").innerHTML = responseData;
             }
         });
    }
    
    function initializeShopPage() {
        // Check if there are products displayed
        const contentDiv = document.getElementById("content");
        const hasProducts = contentDiv.querySelectorAll('.col-md-4').length > 0;
        
        // If no products are displayed, load all products
        if (!hasProducts) {
            console.log("No products found on page load, loading all products...");
            loadAllProducts();
        }
    }         
  </script>
    <!-- Custom scripts -->
    <script type="text/javascript" src="js/script.js"></script>
</body>

</html>