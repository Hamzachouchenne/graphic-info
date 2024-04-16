package fc.IntroIG;

import java.io.File;
import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;

public class marr_hildreth {

	private static double[][] createFilter(int size) {
		double[][] filter = new double[size][size];

		double k = 200;
		int sum = 0;
		// Calculer les valeurs du filtre
		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				double x = i * Math.sqrt(2) / ((size - 1) / 2) - Math.sqrt(2);

				double y = j * Math.sqrt(2) / ((size - 1) / 2) - Math.sqrt(2);

				filter[i][j] = (k * Math.exp(-(x * x + y * y)));
				sum += (int) filter[i][j];
			}
		}

		// Normaliser le filtre

		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				filter[i][j] = (int) filter[i][j];
				filter[i][j] = filter[i][j] / sum;

			}
		}
		return filter;
	}

	public static BufferedImage convolution(BufferedImage image, double[][] filter) {
		int height = image.getHeight();
		int width = image.getWidth();
		BufferedImage resultImage = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_GRAY);

		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				double conv = 0;

				for (int i = 0; i < filter.length; i++) {
					for (int j = 0; j < filter[i].length; j++) {

						if (x - i >= 0 && x - i < width && y - j >= 0 && y - j < height) {
							int pixelValue = (image.getRGB(x - i, y - j)) & 0xFF;
							conv += filter[i][j] * pixelValue;
						}
					}
				}

				int I = (int) conv << 16 | (int) conv << 8 | (int) conv;

				resultImage.setRGB(x, y, I);
			}
		}

		return resultImage;
	}

	public static void Marr_Hildreth(BufferedImage image) {

		int height = image.getHeight();
		int width = image.getWidth();

		double FiltreAnormalise[][] = createFilter(5);
		BufferedImage IA = convolution(image, FiltreAnormalise);

		double FiltreBnormalise[][] = createFilter(7);
		BufferedImage IB = convolution(image, FiltreBnormalise);

		// substitition de deux images
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				image.setRGB(x, y, Math.abs(IB.getRGB(x, y) - IA.getRGB(x, y)));

			}
		}

	}

	public static void main(String[] args) {
		try {
			// Pour construire une image noire
			// BufferedImage image = new BufferedImage(500, 500,
			// BufferedImage.TYPE_INT_RGB);
			// Pour lire une image a partir du disque
			// Vous devez avoir votre dossier workspace Visual Studio Code comme repertoire
			// parent de 'fc.IntroIG'
			// (le repertoire fc.IntroIG lui-meme ne doit pas etre le dossier workspace. Si
			// vous avez ouvert le
			// dossier fc.IntroIG en tant que dossier workspace, fermez Visual Studio Code
			// et recommencez)
			// Ne pas modifier cette ligne de code, ne pas changer le chemin d'acces.
			BufferedImage image = ImageIO.read(new File("building.png"));
			// Pour lire un pixel
			// int color = image.getRGB(0, 0);
			// Pour ecrire un pixel
			image.setRGB(10, 20, 0xFF0000);// trace un point. Format de couleur 0xRRVV

			Marr_Hildreth(image);

			// Sauvegarde
			ImageIO.write(image, "png", new File("resultat_filtrage.png"));

		} catch (Exception e) {
			System.out.println("Exception:");
			e.printStackTrace();
		}
	}
}