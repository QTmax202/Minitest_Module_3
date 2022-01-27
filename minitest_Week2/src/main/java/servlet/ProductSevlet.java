package servlet;

import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import model.Product;
import service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ProductSevlet", value = "/product")
public class ProductSevlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        action(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        action(request,response);
    }

    private void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch(action){
            case "detail":
                displayDetail(request, response);
                break;
            case "sortasc":
                sortAsc(request, response);
                break;
            case "sortdesc":
                sortDesc(request, response);
                break;
            case "detailCart":
                detailCart(request, response);
                break;
            case "addProduct":
                addProduct(request, response);
                break;
            case "delete":
                deleteCart(request, response);
                break;
            case "payment":
                paymentCart(request, response);
                break;
            case "back":
                displayAllProducts(request,response);
            default:
                displayAllProducts(request,response);
        }
    }

    private void paymentCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ArrayList<Product> carts = productService.displayCart();
        int payments = 0;
        for (Product p: carts) {
            payments = p.getQuantily() * p.getPrice();
            carts.remove(p);
        }
        PrintWriter write = response.getWriter();
        write.write("<html>");
        write.write("<h1> Tong so tien phai tra: "+payments+"</h1>");
        write.write("</html>");
//        request.setAttribute("carts", carts);
//        RequestDispatcher requestDispatcher = request.getRequestDispatcher("carts.jsp");
//        requestDispatcher.forward(request, response);
    }

    private void deleteCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("id"));
        productService.removeProduct(id);
        ArrayList<Product> carts = productService.displayCart();
        request.setAttribute("carts", carts);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("carts.jsp");
        requestDispatcher.forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("id"));

        ArrayList<Product> carts = productService.displayCart();
        ArrayList<Product> products = productService.sortDescProducts();
        Product product = productService.getProduct(id);
        boolean check = false;
        for(Product p : carts){
            if (id == p.getId()){
                productService.addProduct(new Product(id, p.getName(), p.getPrice(), p.getQuantily()+1 , p.getDescription()));
                check = true;
                p.setQuantily(p.getQuantily()-1);
            }
        }
        if (!check){
            productService.addProduct(new Product(id, product.getName(), product.getPrice(), 1 , product.getDescription()));
            product.setQuantily(product.getQuantily()-1);
        }

        int index = -1;
        for (int i = 0; i < products.size(); i++) {
            if (products.get(i).getId() == id){
                index = i;
            }
        }
        productService.editProduct(index,product);
        request.setAttribute("products", products);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view.jsp");
        requestDispatcher.forward(request, response);
    }

    private void detailCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ArrayList<Product> carts = productService.displayCart();
        request.setAttribute("carts", carts);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("carts.jsp");
        requestDispatcher.forward(request, response);
    }

    private void sortDesc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ArrayList<Product> products = productService.sortDescProducts();
        request.setAttribute("products", products);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view.jsp");
        requestDispatcher.forward(request, response);
    }

    private void sortAsc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ArrayList<Product> products = productService.sortAscProducts();
        request.setAttribute("products", products);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view.jsp");
        requestDispatcher.forward(request, response);
    }

    private void displayDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProduct(id);
        request.setAttribute("product", product);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view-detail.jsp");
        requestDispatcher.forward(request, response);
    }

    private void displayAllProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ArrayList<Product> products = productService.displayProducts();
        request.setAttribute("products", products);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view.jsp");
        requestDispatcher.forward(request, response);
    }
}
