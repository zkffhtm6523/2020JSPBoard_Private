package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbURL = "jdbc:mysql://localhost:3306/bbs?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int login(String userID, String userPassword ) {
		String SQL = "SELECT userPassword FROM user WHERE userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			System.out.println(111);
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) 
					return 1; //�α��� ����
				else
					return 0; //�α��� ����ġ
			}
			return -1; //���̵� ���� 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
			//try�� ����� ��쿡�� 0�̻��� ���� ��ȯ�� ���� �������� �����̶�� �� �� ����.
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
}
