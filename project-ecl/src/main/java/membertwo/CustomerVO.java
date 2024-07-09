package membertwo;

public class CustomerVO {
	private int userNo; // 사용자 번호
	private String userId; // 사용자 ID
	private String pwd;// 비밀번호
	private String userName; // 사용자 이름
	private String email; // 이메일 (전체 주소)
	private String domain; // 도메인 (필요에 따라)
	private String getMail; // 메일 수신 여부
	private int postal; // 우편번호
	private String address1; // 주소
	private String address2; // 상세 주소
	private String phone; // 휴대폰 번호
	private String regDate; //가입일
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getGetMail() {
		return getMail;
	}
	public void setGetMail(String getMail) {
		this.getMail = getMail;
	}
	public int getPostal() {
		return postal;
	}
	public void setPostal(int postal) {
		this.postal = postal;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Customer [userNo=" + userNo + ", userId=" + userId + ", pwd=" + pwd + ", userName=" + userName
				+ ", email=" + email + ", domain=" + domain + ", getMail=" + getMail + ", postal=" + postal
				+ ", address1=" + address1 + ", address2=" + address2 + ", phone=" + phone + ", regDate=" + regDate
				+ "]";
	}
	
	
}
