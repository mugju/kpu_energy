package main;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.border.EmptyBorder;

import dto.SmartPlugDTO;
import graphHtmlString.GoogleChartProduct;
import javafx.application.Platform;
import javafx.embed.swing.JFXPanel;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.web.WebEngine;
import javafx.scene.web.WebView;

public class ProductGraphFrame extends JFrame implements ActionListener {
	private Button closeBtn;
	private JFXPanel contentPane;
	private WebView webView;
	private WebEngine webEngine;
	private Group group;
	private Scene scene;

	public ProductGraphFrame(List<SmartPlugDTO> smartPlugDTO, String title) {
		setBounds(832, 180, 800, 700);
		contentPane = new JFXPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		setResizable(false);
		closeBtn=new Button("Á¾·á");

		Platform.runLater(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				String htmlString = new GoogleChartProduct().getProductChart(smartPlugDTO, title);
				group = new Group();
				scene = new Scene(group);
				contentPane.setScene(scene);

				webView = new WebView();
				group.getChildren().add(webView);
				webEngine = webView.getEngine();
				webEngine.setJavaScriptEnabled(true);
				webEngine.loadContent(htmlString);
			}

		});
		setVisible(true);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

	}
}
