$pdf_mode = 1;
set_tex_cmds('-synctex=1 -shell-escape -interaction=nonstopmode -file-line-error %O %S');
$out_dir = 'build';

# glossaries: latexmk does not know how to build the .gls/.acr files on its own
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
add_cus_dep('glo', 'gls', 0, 'makeglossaries');

sub makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    return system('makeglossaries', '-d', $path, $base_name);
}

push @generated_exts, 'acn', 'acr', 'alg', 'glg', 'glo', 'gls', 'ist';
