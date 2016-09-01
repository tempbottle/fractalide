{ stdenv, buildFractalideSubnet, upkeepers
  , shells_fsh_prompt
  , shells_fsh_lexer
  , shells_fsh_generator
  , io_print
  # contracts
  , shell_commands
  , ...}:

  buildFractalideSubnet rec {
   src = ./.;
   name = "fsh";
   subnet = ''
   '${shell_commands}:(commands=[ (key="cd", val="shells_commands_cd"),(key="ls", val="shells_commands_ls"),(key="pwd", val="shells_commands_pwd")])~create' ->
   commands lexer()

   prompt(${shells_fsh_prompt}) output ->
   input lexer(${shells_fsh_lexer}) output ->
   input parser(${shells_fsh_generator}) output ->
   input print_list_text(${io_print})
   '';

   meta = with stdenv.lib; {
    description = "Subnet: Fractalide Shell";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}