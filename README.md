This setup allows for a dynamically updating bashrc file. To use this properly add the following lines or something similar to the end of a .bashrc file or login script:

cd ~/.gitbash/
git pull origin master
cd -

. ~/.gitbash/bashrc

This setup allows for multiple accounts over multiple computers to share common aliases, prompts, etc. While being able to still maintain machine-specific settings assuming the presence of git.
