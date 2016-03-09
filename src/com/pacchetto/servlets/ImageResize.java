package com.pacchetto.servlets;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import org.apache.commons.io.FilenameUtils;

public class ImageResize {

    /**
     * Resize delle immagini
     *
     * @param inputImage File di input
     * @param dir Percorso di destinazione salvataggio
     * @param width Larghezza immagine
     * @param height Altezza immagine
     * @throws IOException
     */
    public void resizeImage(File inputImage, String dir, int width, int height) throws IOException {
        Image image = ImageIO.read(inputImage);
        Image newImage = image.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage buf = new BufferedImage(newImage.getWidth(null), newImage.getHeight(null), BufferedImage.TYPE_INT_RGB);
        Graphics2D g2 = buf.createGraphics();
        g2.drawImage(newImage, 0, 0, null);
        g2.dispose();
        String ext = FilenameUtils.getExtension(inputImage.getName());
        ImageIO.write(buf, ext, new File(dir + inputImage.getName()));
    }

}