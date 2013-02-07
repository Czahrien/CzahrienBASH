This setup allows for a dynamically updating bashrc file. To use this properly add the following line a .bashrc file or login script:

```bash
. path_to_git_repo/source_all_files.sh
```

This setup allows for multiple accounts over multiple computers to share common aliases, prompts, etc. While being able to still maintain machine-specific settings assuming the presence of git.
