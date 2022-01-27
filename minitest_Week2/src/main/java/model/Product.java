package model;

public class Product {
    private int id;
    private String Name;
    private int price;
    private int quantily;
    private String description;

    public Product(int id, String name, int price, int quantily, String description) {
        this.id = id;
        Name = name;
        this.price = price;
        this.quantily = quantily;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantily() {
        return quantily;
    }

    public void setQuantily(int quantily) {
        this.quantily = quantily;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
