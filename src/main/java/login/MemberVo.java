package login;

public class MemberVo {
    private String name, userid, userpw,  gender,email, address,detailAddress,extraAddress,phone, admin;
    private int postcode;
    public MemberVo() {
    }

    public MemberVo(String name, String userid, String userpw, String gender, String email, String address, String detailAddress, String extraAddress, String phone, String admin, int postcode) {
        this.name = name;
        this.userid = userid;
        this.userpw = userpw;
        this.gender = gender;
        this.email = email;
        this.address = address;
        this.detailAddress = detailAddress;
        this.extraAddress = extraAddress;
        this.phone = phone;
        this.admin = admin;
        this.postcode = postcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserpw() {
        return userpw;
    }

    public void setUserpw(String userpw) {
        this.userpw = userpw;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public String getExtraAddress() {
        return extraAddress;
    }

    public void setExtraAddress(String extraAddress) {
        this.extraAddress = extraAddress;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public int getPostcode() {
        return postcode;
    }

    public void setPostcode(int postcode) {
        this.postcode = postcode;
    }
}
