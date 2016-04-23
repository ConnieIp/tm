package allClass;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author samsung-pc
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import javax.sql.DataSource;
import java.sql.Statement;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.naming.InitialContext;
import javax.naming.Context;

public class ToyMarketLookup {
	public static Toy getToy(int id) throws NamingException, SQLException {
            Context initCtx = new InitialContext();
            Context envCtx = (Context)initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
            Connection con = ds.getConnection();
		
            PreparedStatement pstmt = con.prepareStatement("SELECT * from [ToyMarket] WHERE [ToyID] = ?");
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            Toy toy=null;
            if (rs != null && rs.next() != false) {
                toy=new Toy(rs.getInt("ToyID"), rs.getString("Name"), rs.getString("Type"), rs.getInt("Age"), rs.getString("Gender"),
                    rs.getString("Description"), rs.getInt("Qty"), rs.getFloat("Price"), rs.getString("ImagePath"), rs.getString("Owner"),
                    rs.getString("RecordDate"), rs.getString("Recycle"));
		}
		if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (con != null) {
            con.close();
        }
		return toy;
	}
	
	public static ArrayList<Toy> getToys(String category) throws NamingException, SQLException{
		Context initCtx = new InitialContext();
        Context envCtx = (Context)initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/ToyMarket");
        Connection con = ds.getConnection();
        
        Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs;
        
        if (category.equalsIgnoreCase("girl")){
            rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [Gender] IN ('F','B') AND [Recycle]<>'R' AND [Recycle] IS NOT NULL ORDER BY [ToyID] ASC");
        }
        else if (category.equalsIgnoreCase("boy")){
            rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [Gender] IN ('M','B') AND [Recycle]<>'R' AND [Recycle] IS NOT NULL ORDER BY [ToyID] ASC");
        }
        else if (category.equalsIgnoreCase("child")){
            rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE ([Age] > 3 OR [Age] = 0) AND [Recycle]<>'R' AND [Recycle] IS NOT NULL ORDER BY [ToyID] ASC");
        }
        else if (category.equalsIgnoreCase("baby")){
            rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE ([Age] BETWEEN 0 AND 3 OR [AGE] = 0) AND [Recycle]<>'R' AND [Recycle] IS NOT NULL ORDER BY [ToyID] ASC");
        }
        else{
            //[RECYCLE]=NULL means not yet processed by manager, [RECYCLE]=Y means recycle, [RECYCLE]=N means not recycle , [RECYCLE]=R means "Rejected" 
            rs = stmt.executeQuery("SELECT * FROM [ToyMarket] WHERE [RECYCLE] IS NOT NULL AND [RECYCLE] <> 'R' ORDER BY [ToyID] ASC");
        }
        ArrayList<Toy> toys = new ArrayList<Toy>();
        while (rs != null && rs.next() != false) {
			//toys = new ArrayList<Toy>();
            Toy toy = getToy(rs.getInt("ToyID"));
            if (toy!=null)
		toys.add(toy);
        }
		if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (con != null) {
            con.close();
        }
		return toys;
	}

}