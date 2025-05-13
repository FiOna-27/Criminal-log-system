package com.example.models;

import java.io.Serializable;

public class Detective implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String number;
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
    
    
    // Helper method
    public String getFullName() {
        return firstName + " " + lastName;
    }
	
}