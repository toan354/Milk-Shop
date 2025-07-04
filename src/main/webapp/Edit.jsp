<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Lưu sản phẩm</title>
            <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
            <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <link href="css/manager.css" rel="stylesheet" type="text/css" />
            <style>
                img {
                    width: 200px;
                    height: 120px;
                }

                .exit-button {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 1000;
                }

                .exit-button a {
                    display: inline-block;
                    padding: 10px 20px;
                    background-color: #dc3545;
                    color: white;
                    text-decoration: none;
                    border-radius: 4px;
                    font-weight: bold;
                    transition: background-color 0.3s ease;
                }

                .exit-button a:hover {
                    background-color: #c82333;
                    text-decoration: none;
                    color: white;
                }

                .exit-button i {
                    margin-right: 5px;
                }

                /* Hiệu ứng hover cho nút Lưu */
                .modal-footer .btn-success {
                    transition: background-color 0.3s ease;
                }

                .modal-footer .btn-success:hover {
                    background-color: #218838;
                }
            </style>

        <body>
            <!-- Thêm nút thoát -->
            <div class="exit-button">
                <a href="manager">
                    <i class="fa fa-times"></i> Thoát
                </a>
            </div>

            <div class="container">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2>Lưu <b>sản phẩm</b></h2>
                            </div>
                            <div class="col-sm-6">
                            </div>
                        </div>
                    </div>
                </div>
                <div id="editEmployeeModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="edit" method="post">
                                <div class="modal-header">
                                    <h4 class="modal-title">Lưu sản phẩm</h4>
                                    <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <!--                          <label>ID</label> -->
                                        <input value="${detail.id}" name="id" type="hidden" class="form-control"
                                            readonly required>
                                    </div>
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input value="${detail.name}" name="name" type="text" class="form-control"
                                            required>
                                    </div>
                                    <div class="form-group">
                                        <label>Image</label>
                                        <input value="${detail.image}" name="image" type="text" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Image 2</label>
                                        <input value="${detail.image2}" name="image2" type="text" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Image 3</label>
                                        <input value="${detail.image3}" name="image3" type="text" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Giá (VNĐ)</label>
                                        <input value="${detail.price}" name="price" type="text" class="form-control"
                                            placeholder="Nhập giá bằng VNĐ">
                                    </div>
                                    <div class="form-group">
                                        <label>Brand</label>
                                        <textarea name="title" class="form-control" required>${detail.title}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Delivery</label>
                                        <textarea name="delivery" class="form-control"
                                            required>${detail.delivery}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="description"
                                            class="form-control">${detail.description}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Category</label>
                                        <select name="category" class="form-select" aria-label="Default select example">
                                            <c:forEach items="${listCC}" var="o">
                                                <option value="${o.cid}">${o.cname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <input type="submit" class="btn btn-success" value="Lưu">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>


            <script src="js/manager.js" type="text/javascript"></script>
        </body>

        </html>