# FTorch Interface

The CESM-side interface to [FTorch](https://github.com/Cambridge-ICCS/FTorch),
a library for coupling PyTorch machine-learning models to Fortran code.

This repository provides the CIME integration (build script and CMake
configuration) that allows FTorch to be used from within CESM.
It also contains the `FTorch_cesm_interface`, a light Fortran module wrapper through
which CESM components call FTorch routines, exiting cleanly when errors occur.
FTorch itself is included as a git submodule under `src/`.

## Version compatibility

FTorch_Interface versions track different CIME configurations and FTorch functionalities.
The FTorch source code is also pinned to specific releases through the git submodule.
Users should be aware that FTorch v2.0.0 introduced breaking API changes which are not
yet supported by the interface and it is currently set to use FTorch `v1.0.0`.

| FTorch  | FTorch_Interface |
|---------|------------------|
| v1.0.0  | v0.0.5           |
| v2.0.0  | TBD              |

An interface release supporting v2.x is in progress.

## Repository structure

- `buildlib` - CIME build script invoked during case build.
- `CMakeLists.txt` - CMake configuration for the interface and FTorch build.
- `FTorch_cesm_interface.F90` - Fortran module wrapping FTorch for CESM,
  including no-op routines when `USE_FTORCH=FALSE` for clean failure.
- `src/` - FTorch library (git submodule).

## Citation

If you use this FTorch in your work, please cite:

> Atkinson et al., (2025). FTorch: a library for coupling PyTorch models to Fortran.
> _Journal of Open Source Software_, 10(107), 7602, [https://doi.org/10.21105/joss.07602](https://doi.org/10.21105/joss.07602)

See the FTorch repository for the full repository citation details and DOI.

## License

This repository is distributed under the terms of the license in
[LICENSE](LICENSE).

## Usage in CESM

The FTorch_interface is brought into a CESM source tree as an external using
[git-fleximod](https://github.com/ESMCI/git-fleximod). Add an entry to the
top-level `.gitmodules` of your CESM checkout if not already present:

```
[submodule "FTorch"]
	path = libraries/FTorch
	url = https://github.com/ESCOMP/FTorch_interface
  fxtag = v0.0.5
  fxrequired = ToplevelOptional
  fxDONOTUSEurl = https://github.com/ESCOMP/FTorch_interface
```

then run:

```
./bin/git-fleximod update --optional
```

Fleximod will pull this down, and also populate the nested FTorch submodule.

> **Note:** Avoid modifying entries in `.gitmodules` inside an already
> populated CESM checkout - `git-fleximod` may not propagate those changes
> correctly on later invocations. Populate a fresh, unpopulated checkout
> instead.

The `buildlib` then builds FTorch and the interface wrapper as shared
libraries when the interface is included in the build.

The version of FTorch built by a given interface checkout is set by the interface
version as described above. The interface version is pinned in `fxtag` entry of
`.gitmodules`.

### Case configuration

When building a simulation case for CESM the following settings need to be updated:

- `USE_FTORCH=TRUE` - to build and interface to FTorch. If `FALSE` (default), the
  interface uses no-op routines that abort at runtime.
- `OS=Linux` - on some systems users need to set this to avoid legacy catamount
  warnings that break dynamic library handling.

This can be done from the case directory with:

```
./xmlchange USE_FTORCH=True
./xmlchange OS=Linux
./case.setup
```
