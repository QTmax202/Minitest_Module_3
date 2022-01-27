package service;

import model.Product;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ProductService {
    private static final ArrayList<Product> producers;
    private static final ArrayList<Product> carts = new ArrayList<>();

    static{
        producers = new ArrayList<>();
        producers.add(new Product(1, "Jordan 1",650000, 1, "nike"));
        producers.add(new Product(2, "Jordan sb",1200000, 3, "nike"));
        producers.add(new Product(3, "Biti's Hunter",750000, 5, "biti's"));
        producers.add(new Product(4, "superstar",2500000, 2, "adidas"));
        producers.add(new Product(5, "UntraBoost",5000000, 3, "adidas"));
    }

    public ArrayList<Product> displayProducts() {
        return producers;
    }

    public ArrayList<Product> displayCart() {
        return carts;
    }

    public Product getProduct(int id){
        for(Product p : producers){
            if (p.getId() == id){
                return p;
            }
        }
        return null;
    }

//    public int paymentCart(ArrayList<Product> carts){
//        int payments = 0;
//        for (Product p: carts) {
//            payments = p.getQuantily() * p.getPrice();
//            carts.remove(p);
//        }
//        return payments;
//    }

//    public void createProduct(Product p){
//        producers.add(p);
//    }

    public void  addProduct(Product p){
        carts.add(p);
    }

    public void removeProduct(int id){
        carts.removeIf((p) ->(p.getId() == id));
    }

//    public void removeProduct(int id){
//        producers.removeIf((p) ->(p.getId() == id));
//    }

    public void editProduct(int index, Product p){
        producers.set(index, p);
    }

    public ArrayList<Product> sortAscProducts() {
        producers.sort((o1, o2) -> (o1.getPrice() - o2.getPrice()));
        return producers;
    }

    public ArrayList<Product> sortDescProducts() {
        producers.sort((o1, o2) -> (o2.getPrice() - o1.getPrice()));
        return producers;
    }

    public ArrayList<Product> searchProductByName(String name){
        ArrayList<Product> productList= new ArrayList<>();
        for(Product p : producers){
            if (validateSearch(name, p.getName())){
                productList.add(p);
            }
        }
        return productList;
    }

    public boolean validateSearch(String key, String regex){
        key = key.toLowerCase();
        String NAME_REGEX = "*"+key+"*";
        Pattern pattern = Pattern.compile(NAME_REGEX);
        Matcher matcher = pattern.matcher(regex.toLowerCase());
        return matcher.matches();
    }
}
