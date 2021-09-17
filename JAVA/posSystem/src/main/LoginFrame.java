package main;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.WindowConstants;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;

import dao.DAO;
import dao.MybatisConnection;
import dto.ClientDTO;

public class LoginFrame extends JFrame implements ActionListener {
	private MainProcess main;

	private JPanel logoPanel, loginPanel;
	private JLabel iconLabel;
	private JLabel label[] = new JLabel[3];
	private JTextField storeText, userText;
	private JPasswordField pwdText;
	private JButton btn[] = new JButton[3];

	private DAO dao;
	private ClientDTO inputClient, resultClient;

	private String labelName[] = { "매점 이름", "아이디", "비밀번호" };
	private int labelY[] = { 27, 80, 132 };
	private String btnName[] = { "리셋", "로그인", "종료" };
	private int btnX[] = { 30, 124, 220 };

	public void setMain(MainProcess main) {
		this.main = main;
	}

	public LoginFrame(MainProcess main) {
		setMain(main);
		setTitle("로그인");
		setResizable(false);
		setSize(450, 500);

		// 창 위치 윈도우 가운데
		Dimension frameSize = getSize();
		Dimension windowSize = Toolkit.getDefaultToolkit().getScreenSize();
		setLocation((windowSize.width - frameSize.width) / 2, (windowSize.height - frameSize.height) / 2);
		setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

		// panel
		JPanel contentPane = new JPanel();
		contentPane.setBackground(Color.DARK_GRAY);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		placeLoginPanel(contentPane);
		add(contentPane);
		setVisible(true);
	}

	public void placeLoginPanel(JPanel contentPane) {
		// 로고 이미지 삽입 창
		logoPanel = new JPanel();
		logoPanel.setBorder(new LineBorder(Color.WHITE, 3));
		logoPanel.setBackground(Color.DARK_GRAY);
		logoPanel.setBounds(5, 5, 425, 125);
		contentPane.add(logoPanel);
		logoPanel.setLayout(null);

		// 로고 이미지
		URL url =this.getClass().getClassLoader().getResource("images/login.jpg");
		iconLabel = new JLabel(new ImageIcon(url));
		iconLabel.setBounds(83, 12, 283, 98);
		logoPanel.add(iconLabel);

		// 로그인 UI삽입 창
		loginPanel = new JPanel();
		loginPanel.setBackground(Color.DARK_GRAY);
		loginPanel.setBorder(new LineBorder(Color.WHITE, 3));
		loginPanel.setBounds(57, 173, 331, 257);
		contentPane.add(loginPanel);
		loginPanel.setLayout(null);

		/*
		 * 로그인 UI : 1. 글씨 라벨 2. 입력 공간 3. 버튼
		 */
		for (int i = 0; i < label.length; i++) {
			label[i] = new JLabel(labelName[i]);
			label[i].setForeground(Color.WHITE);
			label[i].setFont(new Font("굴림", Font.BOLD, 20));
			label[i].setBounds(12, labelY[i], 102, 41);
			loginPanel.add(label[i]);
		}

		storeText = new JTextField();
		storeText.setFont(new Font("굴림", Font.PLAIN, 15));
		storeText.setBounds(126, 36, 178, 21);
		loginPanel.add(storeText);
		storeText.setColumns(20);

		userText = new JTextField();
		userText.setFont(new Font("굴림", Font.PLAIN, 15));
		userText.setColumns(20);
		userText.setBounds(126, 89, 178, 21);
		loginPanel.add(userText);

		pwdText = new JPasswordField();
		pwdText.setFont(new Font("굴림", Font.PLAIN, 15));
		pwdText.setColumns(20);
		pwdText.setBounds(126, 140, 178, 21);
		loginPanel.add(pwdText);

		for (int i = 0; i < btn.length; i++) {
			btn[i] = new JButton(btnName[i]);
			btn[i].setFont(new Font("굴림", Font.BOLD, 15));
			btn[i].setBounds(btnX[i], 190, 84, 35);
			btn[i].addActionListener(this);
			loginPanel.add(btn[i]);
		}

	}

	public void isLoginCheck(String store) {
		int storeId = 0;
		dao = new DAO(MybatisConnection.getSqlSessionFactory());
		inputClient = new ClientDTO();

		inputClient.setId(userText.getText());
		inputClient.setPasswd(new String(pwdText.getPassword()));
		try {
			storeId = dao.getStoreId(storeText.getText());
			inputClient.setStoreId(storeId);
			resultClient = dao.readClientData(inputClient);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao = null;
		}
		if (resultClient != null) {
			inputClient = null;
			main.showFrameMain(resultClient, store); // 메인창 메소드를 이용해 창뛰우기
		} else {
			JOptionPane.showMessageDialog(null, "Faild");
		}
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		String action = e.getActionCommand();

		if (action.equals(btn[0].getText())) {
			storeText.setText("");
			userText.setText("");
			pwdText.setText("");
		} else if (action.equals(btn[1].getText())) {
			isLoginCheck(storeText.getText());
		} else if (action.equals(btn[2].getText())) {
			System.exit(0);
		}
	}
}
