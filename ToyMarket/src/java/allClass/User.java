/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package allClass;

/**
 *
 * @author samsung-pc
 */
public class User {
	private String userId;
	private String userName;
	private String userPw;
	private String userRole;

   public User(String userId, String userName, String userPw, String userRole){
		setUserId(userId);
		setUserName(userName);
		setUserPw(userPw);
		setUserRole(userRole);
	}
	
	public String getUserId(){ return userId; }
	public String getUserName(){ return userName; }
	public String getUserPw(){ return userPw; }
	public String getUserRole(){ return userRole; }
	
	public void setUserId(String userId){ this.userId = userId; }
	public void setUserName(String userName){ this.userName = userName; }
	public void setUserPw(String userPw){ this.userPw = userPw; }
	public void setUserRole(String userRole){ this.userRole = userRole; }
}
