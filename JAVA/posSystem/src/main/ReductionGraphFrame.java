package main;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.border.EmptyBorder;

import dto.SmartPlugDTO;
import graphHtmlString.GoogleChartReduction;
import javafx.application.Platform;
import javafx.embed.swing.JFXPanel;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.web.WebEngine;
import javafx.scene.web.WebView;

public class ReductionGraphFrame extends JFrame implements ActionListener {
	private JFXPanel contentPane;
	private WebView webView;
	private WebEngine webEngine;
	private Group group;
	private Scene scene;

	public ReductionGraphFrame(List<SmartPlugDTO> smartPlugDTO, List<SmartPlugDTO> reductionSmartPlugDTO,
			String title) {
		setBounds(832, 180, 800, 700);
		contentPane = new JFXPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		setResizable(false);

		Platform.runLater(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				String htmlString = new GoogleChartReduction().getReductionChart(smartPlugDTO, reductionSmartPlugDTO, title);

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
