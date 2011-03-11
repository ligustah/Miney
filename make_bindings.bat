@echo off
cd bindings
for %%X in (*.md) do mdcl %%X
cd ..