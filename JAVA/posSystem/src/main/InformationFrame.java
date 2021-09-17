package main;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import javax.swing.Timer;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;

public class InformationFrame extends JFrame implements ActionListener {
	private JPanel panel;
	private JButton btnClose;
	private JLabel textLabel;
	private final int time = 5000;
	private Timer timer;

	public InformationFrame(String value) {
		setTitle("알림");
		setResizable(false);
		setSize(450, 150);
		setVisible(true);

		Dimension frameSize = getSize();
		Dimension windowSize = Toolkit.getDefaultToolkit().getScreenSize();
		setLocation((windowSize.width - frameSize.width) / 2, (windowSize.height - frameSize.height) / 2);

		JPanel contentPane = new JPanel();
		contentPane.setBackground(Color.DARK_GRAY);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		placePanel(contentPane, value);
		add(contentPane);
		contentPane.setLayout(null);
	}

	public void placePanel(JPanel contentPane, String value) {
		panel = new JPanel();
		panel.setBorder(new LineBorder(Color.WHITE, 3));
		panel.setBackground(Color.DARK_GRAY);
		panel.setBounds(12, 10, 410, 90);
		contentPane.add(panel);
		panel.setLayout(null);
		
		if(value.equals("0")) {
			value="스마트플러그가 꺼졌습니다.";
		}else {
			value="스마트 플러그가 켜졌습니다.";
		}

		textLabel = new JLabel(value);
		textLabel.setForeground(Color.WHITE);
		textLabel.setHorizontalAlignment(SwingConstants.CENTER);
		textLabel.setFont(new Font("굴림", Font.BOLD, 12));
		textLabel.setBounds(49, 20, 309, 29);
		panel.add(textLabel);

		btnClose = new JButton("확인");
		btnClose.setFont(new Font("굴림", Font.BOLD, 12));
		btnClose.setBounds(163, 59, 97, 23);
		btnClose.addActionListener(this);
		panel.add(btnClose);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		String action = e.getActionCommand();
		
		if (action.equals(btnClose.getText())) {
			dispose();
		}
	}
}
