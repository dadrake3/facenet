from cx_Freeze import setup, Executable

# Dependencies are automatically detected, but it might need
# fine tuning.
buildOptions = dict(packages = [
'tensorflow',
'scipy',
'sklearn',
'cv2',
'h5py',
'matplotlib',
'numpy',
'PIL',
'requests',
'psutil',
'Pyro4',
'traceback'
], excludes = [])

import sys
base = 'Win32Service' if sys.platform=='win32' else None

executables = [
    Executable('face_id_main.py', base=base, targetName = 'main')
]

setup(name='face_id',
      version = '1.0',
      description = 'face',
      options = dict(build_exe = buildOptions),
      executables = executables)
