package allClass;
import java.util.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author samsung-pc
 */
public class Toy {
	private int toyid;
	private String toyname;
	private String toytype;
	private int age;
	private String gender;
	private String description;
	private int qty;
	private float price;
	private String imgPath;
	private String owner;
	private String recorddate;
	private String recycle;

	public Toy(int toyid, String toyname, String toytype, int age, String gender, String description, int qty, float price,
            String imgPath, String owner, String recorddate, String recycle) {
                setToyid(toyid);
		setToyname(toyname);
		setToytype(toytype);
		setAge(age);
		setGender(gender);
		setDescription(description); 
		setQty(qty);
		setPrice(price);
		setImgPath(imgPath);
		setOwner(owner);
		setRecorddate(recorddate);
		setRecycle(recycle);
	}
	
	public int getToyid(){ return toyid; }
	public String getToyname(){ return toyname; }
	public String getToytype(){ return toytype; }
	public int getAge(){ return age; }
	public String getGender(){ return gender; }
	public String getDescription(){ return description; }
	public int getQty(){ return qty; }
	public float getPrice(){ return price; }
	public String getOwner(){ return owner; }
	public String getImgPath(){ return imgPath; }
	public String getRecorddate(){ return recorddate; }
	public String getRecycle() { return recycle; }
	
	public void setToyid(int toyid){ this.toyid = toyid; }
	public void setToyname(String toyname){ this.toyname = toyname; }
	public void setToytype(String toytype){ this.toytype = toytype; }
	public void setAge(int age){ this.age = age; }
	public void setGender(String gender){ this.gender = gender; }
	public void setDescription(String description){ this.description = description; }
	public void setQty(int qty){ this.qty = qty; }
	public void setPrice(float price){ this.price = price; }
	public void setOwner(String owner){ this.owner = owner; }
	public void setImgPath(String imgPath){ this.imgPath = imgPath; }
	public void setRecorddate(String Recorddate){ this.recorddate = recorddate; }
	public void setRecycle(String recycle) { this.recycle = recycle; }
}

