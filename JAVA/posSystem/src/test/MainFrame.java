package test;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.Toolkit;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
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
import main.MainProcess;
import mqtt.MyMqttClient;

public class MainFrame extends JFrame {

	private JPanel contentPane;
	private MyMqttClient mClient;
	private MainProcess main = new MainProcess();
	private ClientDTO client;

	private JPanel menuPanel, posPanel;
	private JLabel storeLabel;
	private JTextArea menuView;
	private JButton btnMain[] = new JButton[4];
	private JButton btnSub[] = new JButton[18];
	private JTextPane smPlugPane;
	private JTextPane sctPane;
	private JTextPane totalPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MainFrame frame = new MainFrame();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public MainFrame() {
		setFont(new Font("굴림", Font.BOLD | Font.ITALIC, 12));
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
				getContentPane().add(contentPane);
				setVisible(true);
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
		menuView.setFont(new Font("MV Boli", Font.BOLD | Font.ITALIC, 30));
		menuView.setBounds(10, 10, 616, 352);
		posPanel.add(menuView);
		
		smPlugPane = new JTextPane();
		smPlugPane.setEditable(false);
		smPlugPane.setBackground(Color.WHITE);
		smPlugPane.setFont(new Font("굴림", Font.BOLD, 15));
		smPlugPane.setBounds(638, 10, 310, 108);
		
		StyledDocument doc = smPlugPane.getStyledDocument();
		SimpleAttributeSet center = new SimpleAttributeSet();
		StyleConstants.setAlignment(center, StyleConstants.ALIGN_CENTER);
		doc.setParagraphAttributes(0, doc.getLength(), center, false);
		try {
			doc.insertString(0, "hi", center);
			doc.insertString(doc.getLength(), "hello", center);
		} catch (BadLocationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		posPanel.add(smPlugPane);
		
		sctPane = new JTextPane();
		sctPane.setFont(new Font("굴림", Font.BOLD, 15));
		sctPane.setEditable(false);
		sctPane.setBackground(Color.WHITE);
		sctPane.setBounds(638, 132, 310, 108);
		posPanel.add(sctPane);
		
		totalPane = new JTextPane();
		totalPane.setFont(new Font("굴림", Font.BOLD, 15));
		totalPane.setEditable(false);
		totalPane.setBackground(Color.WHITE);
		totalPane.setBounds(638, 254, 310, 108);
		posPanel.add(totalPane);

	}
}
