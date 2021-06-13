from pdf2image import convert_from_path

def convert_pdf2imgs(pdf_path, output_path):
    """ Convert pdf to jpg images """
    images_from_path = convert_from_path(pdf_path, dpi=500, output_folder=output_path)
    
    for i, image in enumerate(images_from_path):
        image.save('val{}.png'.format(i), 'PNG')


if __name__ == "__main__":
    PDF_PATH = "./../demo/"
    OUTPUT_PATH = "tmp/test"
    convert_pdf2imgs(PDF_PATH, OUTPUT_PATH)
