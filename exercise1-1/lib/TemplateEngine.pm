use strict;
use warnings;
use utf8;
use FindBin::libs;
use HTML::Entities;
package TemplateEngine;

sub new {
	my ($class, %hash) = @_;
    bless {file => $hash{file}}, $class;
}

sub render {
	my ($this, $args) = @_;
	my $file = $this->{file};

    # テンプレートロード
    open FH, $file or die;
	my @lines = <FH>;
	close (FH);

    # エスケープ
    my %hash = %$args;
    foreach (keys %hash) {
        my $key = $_;
        $_ = $hash{$_};
        s/&/&amp;/g;
        s/</&lt;/g;
        s/>/&gt;/g;
        s/"/&quot;/g;
        $hash{$key} = $_;
    }

    # 置換
    my $html = '';
    foreach (@lines) {
        s/{%\s*(\w+)\s*%}/$hash{$1}/g;
        $html .= $_;
    }

	$html;
}

1;
