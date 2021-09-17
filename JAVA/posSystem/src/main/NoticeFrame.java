package main;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;

import dao.DAO;
import dao.MybatisConnection;
import dto.NoticeDTO;

public class NoticeFrame extends JFrame implements ActionListener {
	private DAO dao;
	private List<NoticeDTO> noticeDTO;
	private JPanel contentPane, titlePanel;
	private JButton repaintBtn, closeBtn;
	private JLabel titleLabel;
	private JTextArea textArea;
	private JScrollPane scroll;
	private int store_id;

	public NoticeFrame(int store_id) {
		this.store_id = store_id;
		setTitle("알림");
		setBounds(832, 180, 600, 800);
		setResizable(false);

		dao = new DAO(MybatisConnection.getSqlSessionFactory());
		try {
			noticeDTO = dao.readNotice(store_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao = null;
		}

		contentPane = new JPanel();
		contentPane.setBackground(Color.DARK_GRAY);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		placeNoticePanel(contentPane);
		add(contentPane);
		setVisible(true);
	}

	public void placeNoticePanel(JPanel contentPane) {
		titlePanel = new JPanel();
		titlePanel.setBorder(new LineBorder(Color.WHITE, 3));
		titlePanel.setBackground(Color.DARK_GRAY);
		titlePanel.setBounds(12, 10, 560, 111);
		contentPane.add(titlePanel);
		titlePanel.setLayout(null);

		titleLabel = new JLabel("알림");
		titleLabel.setFont(new Font("굴림", Font.BOLD | Font.ITALIC, 25));
		titleLabel.setForeground(Color.WHITE);
		titleLabel.setBounds(24, 33, 56, 39);
		titlePanel.add(titleLabel);

		repaintBtn = new JButton("새로고침");
		repaintBtn.setFont(new Font("굴림", Font.BOLD, 15));
		repaintBtn.setBounds(337, 38, 97, 35);
		repaintBtn.addActionListener(this);
		titlePanel.add(repaintBtn);

		closeBtn = new JButton("종료");
		closeBtn.setFont(new Font("굴림", Font.BOLD, 15));
		closeBtn.setBounds(446, 38, 97, 35);
		closeBtn.addActionListener(this);
		titlePanel.add(closeBtn);

		textArea = new JTextArea();
		scroll = new JScrollPane(textArea);
		scroll.setSize(560, 599);
		scroll.setLocation(12, 152);
		textArea.setEditable(false);
		textArea.setBounds(62, 149, 460, 602);
		textArea.append("\n      \t시간\t\t" + "|\t" + "      내용\n");
		textArea.append(
				"    --------------------------------------------------------------------------------------------------------------------------------------\n");

		for (int i = noticeDTO.size() - 1; i > -1; i--) {
			textArea.append("      \t" + noticeDTO.get(i).getDate() + "\t|\t" + noticeDTO.get(i).getContents() + "\n");
			textArea.append(
					"    --------------------------------------------------------------------------------------------------------------------------------------\n");
		}
		contentPane.add(scroll);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		String action = e.getActionCommand();

		if (action.equals(repaintBtn.getText())) {
			dispose();
			new NoticeFrame(store_id);
		} else if (action.equals(closeBtn.getText())) {
			dispose();
		}

	}
}
