package com.lunatech.webapp;

public class Events {
	
	String eventId;
	String eventType;
	
	public Events(String eventId, String eventType){
		
		setEventType(eventType);
		setEventId(eventId);
	}
	public String getEventId() {
		return eventId;
	}
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	

}
