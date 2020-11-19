import os.path
import pickle
import sys
import warnings
import torchvision

_project_folder_ = os.path.abspath('../')
if _project_folder_ not in sys.path:
    sys.path.insert(0, _project_folder_)

from . base_eval import SketchR2CNNEval

if __name__ == '__main__':
    app = SketchR2CNNEval()

    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        images = app.partial_run()

        #save the images as output pngs
        for i in range(images.size(0)):
                torchvision.utils.save_image(images[i, :, :, :], f'{_project_folder_}/outputs/{i}.png')