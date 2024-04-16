package fc.IntroIG;

import java.io.File;
import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;

public class squelatisation {
	public static void passe1(BufferedImage image) {
		int height = image.getHeight();
		int width = image.getWidth();

		boolean[][] b = new boolean[width][height];

		for (int x = 1; x < width - 1; x++) {
			for (int y = 1; y < height - 1; y++) {

				// tableau de voisins

				boolean[] v = { (image.getRGB(x, y + 1) & 0xFF) == 0, (image.getRGB(x + 1, y + 1) & 0xFF) == 0,
						(image.getRGB(x + 1, y) & 0xFF) == 0, (image.getRGB(x + 1, y - 1) & 0xFF) == 0,
						(image.getRGB(x, y - 1) & 0xFF) == 0, (image.getRGB(x - 1, y - 1) & 0xFF) == 0,
						(image.getRGB(x - 1, y) & 0xFF) == 0, (image.getRGB(x - 1, y + 1) & 0xFF) == 0 };

				int nbvoisin = 0;
				int nbtrans = 0;

				for (int i = 0; i < 8; i++) {
					if (v[i] == true) {

						nbvoisin++;
					}
					if ((v[i] == false && v[(i + 1) % 8] == true)) {

						nbtrans++;
					}
				}

				if ((v[0] || v[2] || v[4]) == true && (v[2] == true || v[4] == true || v[6] == true)
						&& (image.getRGB(x, y) != 0xFF000000) && (nbvoisin >= 2 && nbvoisin <= 6) && (nbtrans == 1)) {

					b[x][y] = true;
				}

			}
		}
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				if (b[x][y] == true) {
					image.setRGB(x, y, 0xFF000000);
				}
			}
		}

	}

	public static void passe2(BufferedImage image) {
		int height = image.getHeight();
		int width = image.getWidth();

		boolean[][] b = new boolean[width][height];

		for (int x = 1; x < width - 1; x++) {
			for (int y = 1; y < height - 1; y++) {

				// tableau de voisins

				boolean[] v = { (image.getRGB(x, y + 1) & 0xFF) == 0, (image.getRGB(x + 1, y + 1) & 0xFF) == 0,
						(image.getRGB(x + 1, y) & 0xFF) == 0, (image.getRGB(x + 1, y - 1) & 0xFF) == 0,
						(image.getRGB(x, y - 1) & 0xFF) == 0, (image.getRGB(x - 1, y - 1) & 0xFF) == 0,
						(image.getRGB(x - 1, y) & 0xFF) == 0, (image.getRGB(x - 1, y + 1) & 0xFF) == 0 };

				int nbvoisin = 0;
				int nbtrans = 0;

				for (int i = 0; i < 8; i++) {
					if (v[i] == true) {

						nbvoisin++;
					}
					if ((v[i] == false && v[(i + 1) % 8] == true)) {

						nbtrans++;
					}
				}

				if ((v[0] || v[2] || v[6]) == true && (v[0] == true || v[4] == true || v[6] == true)
						&& (image.getRGB(x, y) != 0xFF000000) && (nbvoisin >= 2 && nbvoisin <= 6) && (nbtrans == 1)) {

					b[x][y] = true;
				}

			}
		}
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				if (b[x][y] == true) {
					image.setRGB(x, y, 0xFF000000);
				}
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
			BufferedImage image = ImageIO.read(new File("tools_blackandwhite.png"));
			// Pour lire un pixel
			// int color = image.getRGB(0, 0);
			// Pour ecrire un pixel
			image.setRGB(10, 20, 0xFF0000);// trace un point. Format de couleur 0xRRVVBB

			

			for (int i = 0; i < 20; i++) {
				passe1(image);
				passe2(image);
			}

			// Sauvegarde
			ImageIO.write(image, "png", new File("resultat_squelatisation.png"));

		} catch (Exception e) {
			System.out.println("Exception:");
			e.printStackTrace();
		}
	}
}
