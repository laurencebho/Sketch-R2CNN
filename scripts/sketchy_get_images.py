import numpy as np
import os.path
import sys
import warnings

_project_folder_ = os.path.abspath('../')
if _project_folder_ not in sys.path:
    sys.path.insert(0, _project_folder_)

from scripts.base_eval import SketchR2CNNEval


class SketchySketchR2CNNEval(SketchR2CNNEval):

    def __init__(self):
        super().__init__()
        self.chosen_fold = 0

    def set_fold(self, idx):
        self.chosen_fold = idx

    def prepare_dataset(self, dataset):
        super().prepare_dataset(dataset)
        dataset.set_fold(self.chosen_fold)

    def checkpoint_prefix(self):
        ckpt = self.config['checkpoint']
        return ckpt.format(self.chosen_fold)


if __name__ == '__main__':
    app = SketchySketchR2CNNEval()

    with warnings.catch_warnings():
        warnings.simplefilter('ignore')

        app.set_fold(0) #run on whole ds
        app.partial_run()
        '''
        for fidx in range(3):
            app.set_fold(fidx)
            app.partial_run()
        '''