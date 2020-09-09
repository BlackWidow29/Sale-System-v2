package application.Views;

import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class ListCashiers {
	public void startOpen(ImageView imgList) {
		Stage stage = (Stage) imgList.getScene().getWindow();
		stage.close();
		try {
			VBox root = (VBox) FXMLLoader.load(getClass().getResource("ListCashiersOpen.fxml"));
			Scene scene = new Scene(root, 387, 316);
			Stage newWindow = new Stage();
			newWindow.setTitle("M&N Bebidas");
			newWindow.setResizable(false);
			newWindow.setScene(scene);
			newWindow.show();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void startClose(ImageView imgList) {
		try {
			VBox root = (VBox) FXMLLoader.load(getClass().getResource("ListCashiersClose.fxml"));
			Scene scene = new Scene(root, 387, 316);
			Stage newWindow = new Stage();
			newWindow.setTitle("M&N Bebidas");
			newWindow.setResizable(false);
			newWindow.setScene(scene);
			newWindow.show();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
