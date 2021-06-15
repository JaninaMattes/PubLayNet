import os
from os import path
from glob import glob 
from pdf2image import convert_from_path

def convert_pdf2imgs(pdf_path, output_path):
    """ Convert pdf to jpg images """
    try:
        for pdf_file in pdf_path:
            if pdf_file.endswith('.pdf'):
                pages = convert_from_path(pdf_file, dpi=300)
                pdf_file = pdf_file.split("/")[2][:-4]
                # save jpg images
                for page in pages:
                    file_name= '{}{}-{}val.png'.format(output_path, pdf_file, pages.index(page))
                    page.save(file_name, 'PNG') 
    except Exception as e:
        print("Exception occured {}".format(e))

def find_pdfs(dir, ext):
    return glob(path.join(dir,"*.{}".format(ext)))

if __name__ == "__main__":
    PDF_DIR = "demo/data/"
    OUTPUT_PATH = "tmp/infer_simple/"
    PDF_PATH = find_pdfs(PDF_DIR, ext='pdf')
    convert_pdf2imgs(PDF_PATH, OUTPUT_PATH)
