package main;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;

import org.eclipse.paho.client.mqttv3.MqttException;

import mqtt.MyMqttClient;

public class ControlFrame extends JFrame implements ActionListener {
	private JPanel panel;
	private JButton onBtn;
	private JButton offBtn;
	private JButton btnClose;
	private MyMqttClient mClient;

	public void setMQTT(MyMqttClient mClient) {
		this.mClient = mClient;
	}

	public ControlFrame(MyMqttClient mClient) {
		setMQTT(mClient);
		setTitle("제어");
		setBounds(832, 180, 450, 200);
		JPanel contentPane = new JPanel();
		contentPane.setBackground(Color.DARK_GRAY);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		placeControlFrame(contentPane);
		add(contentPane);
		setVisible(true);
		setResizable(false);
	}

	public void placeControlFrame(JPanel contentPane) {
		panel = new JPanel();
		panel.setBorder(new LineBorder(Color.WHITE, 3));
		panel.setBackground(Color.DARK_GRAY);
		panel.setBounds(12, 10, 420, 151);
		contentPane.add(panel);
		panel.setLayout(null);
		

		onBtn = new JButton("스마트플러그온");
		onBtn.setFont(new Font("굴림", Font.BOLD, 12));
		onBtn.setBounds(43, 24, 138, 31);
		onBtn.addActionListener(this);
		panel.add(onBtn);

		offBtn = new JButton("스마트플러그오프");
		offBtn.setFont(new Font("굴림", Font.BOLD, 12));
		offBtn.setBounds(236, 24, 138, 31);
		offBtn.addActionListener(this);
		panel.add(offBtn);

		btnClose = new JButton("종료");
		btnClose.setFont(new Font("굴림", Font.BOLD, 12));
		btnClose.setBounds(165, 118, 97, 23);
		btnClose.addActionListener(this);
		panel.add(btnClose);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		String action = e.getActionCommand();

		if (action.equals(onBtn.getText())) {
			try {
				mClient.sender("Smplug1", "1");
			} catch (MqttException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} else if (action.equals(offBtn.getText())) {
			try {
				mClient.sender("Smplug1", "0");
			} catch (MqttException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} else {
			dispose();
		}
	}
}
