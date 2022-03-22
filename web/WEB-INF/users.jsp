<%-- 
    Document   : users
    Created on : Mar 3, 2022, 4:18:21 PM
    Author     : Xin Su
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </head>
    <body>
        <h1 align='center'>Xin's User Management System</h1><br>   
        <div align='center' class="container">  
            <div class="row">  
                <div class="col-2">
                    <h2>Add User</h2><br><br>
                    <form method="POST">
                        <input type="hidden" name="type" value="add"/>
                    <div>
                        <input type="text" name="email" class="form-control" required placeholder="Email"/>
                    </div>
                    <div>
                        <input type="text" name="first_name" class="form-control" placeholder="First Name"/>
                    </div>
                    <div>
                        <input type="text" name="last_name" class="form-control" placeholder="Last Name"/>
                    </div>
                    <div>
                        <input type="password" name="password" class="form-control" placeholder="Password"/>
                    </div>
                    <div>
                        <select name="role" class="form-select" aria-label="Default select example">
                        <option selected value="1">system admin</option>
                        <option value="2">regular user</option>
                        <option value="3">company admin</option>
                        </select>
                    </div>
                        <input value="Save" type="submit" class="btn btn-primary">                           
                    </form>

                </div>
                <div class="col-8">
                    <h2>Manage Users</h2>       
                    <table class="table">
                        <thead>
                            <tr>
                                <th>E-mail</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Role</th>
                                <th>Active</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr id="${user.email}">
                                    <td>${user.email}</td>
                                    <td>${user.firstName}</td>
                                    <td>${user.lastName}</td>
                                    <td data-role="${user.role.roleId}">${user.role.roleName}</td>
                                    <td>${user.active ? "Y" : "N"}</td>
                                    <td>
                                        <button type="button" onclick="edit_user('${user.email}')" class="btn btn-link">Edit</button>
                                        <form method="POST">
                                        <input type="hidden" name="type" value="delete" />
                                        <input type="hidden" name="email" value="${user.email}"/>
                                        <input type="submit" value="Delete" class="btn btn-link"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>       
                    </table>
                </div>
                <div class="col-2">
                    <h2>Edit User</h2><br><br>
                        <form id="reset" method="POST">
                            <input type="hidden" name="type" value="update"/>
                            <div>
                                <input type="text" name="email" id="edit_email" class="form-control" placeholder="Email" required readonly/>
                            </div>
                            <div>
                                <input type="text" name="first_name" id="edit_first" class="form-control" placeholder="First Name"/>
                            </div>
                            <div>
                                <input type="text"  name="last_name" id="edit_last" class="form-control" placeholder="Last Name"/>
                            </div>
                            <div>
                                <input type="password"  name="password" id="edit_last" class="form-control" placeholder="Password"/>
                            </div>
                            <div>
                                <select name="role" class="form-select" id="edit_role" aria-label="Default select example">
                                <option selected value="1">system admin</option>
                                <option value="2">regular user</option>
                                <option value="3">company admin</option>
                                </select>
                            </div>
                                <input value="Save" type="submit" class="btn btn-primary">
                                <button onclick="reset_edit()" type="button" class="btn btn-primary"> Cancel </button>
                        </form>
                </div>
            </div>
        </div>
        <script>
            function edit_user(email) {
                var tr = document.getElementById(email).children;
                var first_name = tr[1].innerHTML;
                var last_name = tr[2].innerHTML;
                var role = tr[3].getAttribute("data-role");
                document.getElementById("edit_email").value = email;
                document.getElementById("edit_first").value = first_name;
                document.getElementById("edit_last").value = last_name;
                document.getElementById("edit_role").value = role;
            }
            
            function reset_edit() {
            document.getElementById("reset").reset();
            }
        </script>
    </body>
</html>

