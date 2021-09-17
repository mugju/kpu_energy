package main;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.function.Consumer;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextPane;
import javax.swing.WindowConstants;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;
import javax.swing.text.BadLocationException;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyledDocument;

import dto.ClientDTO;
import mqtt.MyMqttClient;

public class MainFrame extends JFrame implements ActionListener {
	private MyMqttClient mClient;
	private MainProcess main = new MainProcess();
	private ClientDTO client;

	private JPanel menuPanel, posPanel;
	private JLabel storeLabel;
	private JTextArea menuView;
	private JTextPane[] textPane = new JTextPane[3];
	private JButton btnMain[] = new JButton[4];
	private JButton btnSub[] = new JButton[18];
	
	private StyledDocument[] doc=new StyledDocument[3];
	private SimpleAttributeSet center;
	private String store;
	private String mainName[] = { "로그아웃", "알림", "제어", "그래프" };
	private String subName[] = { "아메리카노", "아이스아메리카노", "카페라떼", "에스프레소", "카라멜 마끼야또", "바닐라라떼", "망고 스무디", "아이스초코", "핫초코",
			"딸기 스무디", "버블티", "딸기라떼", "기프트콘", "현금", "카드", "쿠폰", "마일리지", "계산" };
	private String textPaneName[] = { "스마트플러그 순간전력\n", "배전반 순간전력\n", "배전반 누적전력\n" };

	// 버튼 좌표
	private int mainX[] = { 505, 614, 723, 832 };
	private int subXY[][] = { { 10, 372 }, { 166, 372 }, { 327, 372 }, { 495, 372 }, { 661, 372 }, { 824, 372 },
			{ 10, 491 }, { 166, 491 }, { 327, 491 }, { 495, 491 }, { 661, 491 }, { 824, 491 }, { 10, 613 },
			{ 166, 613 }, { 327, 613 }, { 495, 613 }, { 661, 613 }, { 824, 613 } };
	private int paneY[] = { 10, 132, 254 };

	public MainFrame(ClientDTO client, String store) {
		// 고객 정보 등록
		this.client = client;
		this.store = store;

		// JFrame 설정
		setTitle("메인");
		setSize(1000, 820);
		setResizable(false);

		// 창 위치 윈도우 가운데
		Dimension frameSize = getSize();
		Dimension windowSize = Toolkit.getDefaultToolkit().getScreenSize();
		setLocation((windowSize.width - frameSize.width) / 2, (windowSize.height - frameSize.height) / 2);
		setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

		// 메인 판넬 설정
		JPanel contentPane = new JPanel();
		contentPane.setBackground(Color.DARK_GRAY);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		placeMainPanel(contentPane);
		add(contentPane);
		setVisible(true);
		startMqtt();

	}

	public void startMqtt() {
		// mqtt 서버 연결
		final Consumer<HashMap<Object, Object>> pdk = (arg) -> { // 메시지를 받는 콜백 행위
			arg.forEach((key, value) -> {
				if (!value.equals("99") && key.equals("message")) {
					changeValue(arg);
				}
			});
		};
		mClient = new MyMqttClient(pdk); // 해당 함수를 생성자로 넣어준다.
		mClient.init("test", "test", "tcp://elijah.iptime.org", "MY_TOPIC")
				.subscribe(new String[] { "People", "Smplug1", "Smplug1_elec", "SCT013", "Total_power" });

	}

	public void placeMainPanel(JPanel contentPane) {
		// 상단 매장 이름, 버튼 삽입 창
		menuPanel = new JPanel();
		menuPanel.setBorder(new LineBorder(Color.WHITE, 3));
		menuPanel.setForeground(Color.BLACK);
		menuPanel.setBackground(Color.DARK_GRAY);
		menuPanel.setBounds(12, 10, 960, 54);
		menuPanel.setLayout(null);
		contentPane.add(menuPanel);

		// 매장 이름
		storeLabel = new JLabel(store);
		storeLabel.setBounds(12, 10, 140, 34);
		storeLabel.setFont(new Font("굴림", Font.BOLD | Font.ITALIC, 20));
		storeLabel.setForeground(Color.WHITE);
		menuPanel.add(storeLabel);

		// 로그아웃, 알림, 그래프 버튼 생성
		for (int i = 0; i < btnMain.length; i++) {
			btnMain[i] = new JButton(mainName[i]);
			btnMain[i].setBounds(mainX[i], 18, 97, 23);
			btnMain[i].setForeground(Color.BLACK);
			btnMain[i].setFont(new Font("굴림", Font.BOLD, 12));
			btnMain[i].setBackground(Color.WHITE);
			btnMain[i].addActionListener(this);
			menuPanel.add(btnMain[i]);
		}

		// 포스기 모양 구현할 창
		posPanel = new JPanel();
		posPanel.setBorder(new LineBorder(Color.WHITE, 3));
		posPanel.setBackground(Color.DARK_GRAY);
		posPanel.setBounds(12, 74, 960, 697);
		contentPane.add(posPanel);
		posPanel.setLayout(null);

		// 메뉴 선택시 나올 예시 공간
		menuView = new JTextArea();
		menuView.setEditable(false);
		menuView.setText("메뉴 선택시 표시되는 곳");
		menuView.setFont(new Font("Monospaced", Font.PLAIN, 30));
		menuView.setToolTipText("");
		menuView.setBounds(10, 10, 616, 352);
		posPanel.add(menuView);

		for (int i = 0; i < textPane.length; i++) {
			textPane[i] = new JTextPane();
			textPane[i].setEditable(false);
			textPane[i].setBackground(Color.WHITE);
			textPane[i].setFont(new Font("굴림", Font.BOLD, 15));
			textPane[i].setBounds(638, paneY[i], 310, 108);
			doc[i] = textPane[i].getStyledDocument();
			center = new SimpleAttributeSet();
			StyleConstants.setAlignment(center, StyleConstants.ALIGN_CENTER);
			doc[i].setParagraphAttributes(0, doc[i].getLength(), center, false);
			try {
				doc[i].insertString(0, textPaneName[i], center);
			} catch (BadLocationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			posPanel.add(textPane[i]);
		}

		// 메뉴 및 기능 임시 버튼 생성
		for (int i = 0; i < btnSub.length; i++) {
			btnSub[i] = new JButton(subName[i]);
			btnSub[i].setBounds(subXY[i][0], subXY[i][1], 124, 74);
			posPanel.add(btnSub[i]);
		}
	}

	public void changeValue(HashMap<Object, Object> arg) {
		String values[] = new String[2];
		int i = 0;

		for (Entry<Object, Object> entry : arg.entrySet()) {
			values[i++] = (String) entry.getValue();
		}

		if (values[0].equals("Smplug1")) {
			new InformationFrame(values[1]);
		} else {
			if (values[0].equals("Smplug1_elec")) {
				try {
					int to = Integer.parseInt(values[1]);
					if(to>=500) {
						StyleConstants.setForeground(center, Color.RED);
					}else {
						StyleConstants.setForeground(center, Color.BLACK);
					}
					textPane[0].setText(" ");
					doc[0].insertString(0, textPaneName[0], center);
					doc[0].insertString(doc[0].getLength(), values[1] + " W\n", center);
				} catch (BadLocationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} if (values[0].equals("SCT013")) {
				try {
					int to = Integer.parseInt(values[1]);
					if(to>=500) {
						StyleConstants.setForeground(center, Color.RED);
					}else {
						StyleConstants.setForeground(center, Color.BLACK);
					}
					textPane[1].setText(" ");
					doc[1].insertString(0, textPaneName[1], center);
					doc[1].insertString(doc[1].getLength(), values[1] + " W\n", center);
				} catch (BadLocationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} if (values[0].equals("Total_power")) {
				try {
					int to = Integer.parseInt(values[1]);
					if(to>=500) {
						StyleConstants.setForeground(center, Color.RED);
					}else {
						StyleConstants.setForeground(center, Color.BLACK);
					}
					textPane[2].setText(" ");
					doc[2].insertString(0, textPaneName[2], center);
					doc[2].insertString(doc[2].getLength(), values[1] + " KW\n", center);
				} catch (BadLocationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		String action = e.getActionCommand();

		if (action.equals(btnMain[0].getText())) {
			client = null;
			mClient.close();
			JOptionPane.showMessageDialog(null, "Logout");
			dispose();
			MainProcess.main(null);
		} else if (action.equals(btnMain[1].getText())) {
			main.showNotice(client.getStoreId());
		} else if (action.equals(btnMain[2].getText())) {
			main.control(mClient);
		} else if (action.equals(btnMain[3].getText())) {
			main.setGraph(client);
		}
	}

}
