use ExtUtils::MakeMaker;
WriteMakefile(
    DISTNAME     => 'Sub-Fallback',
    NAME         => 'Sub::Fallback',
    VERSION_FROM => 'lib/Sub/Fallback.pm',
    PREREQ_PM    => { Exporter => 0 },
    'dist'       => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    ($] >= 5.005 ? 
       (ABSTRACT_FROM => 'lib/Sub/Fallback.pm',
        AUTHOR        => 'Steven Schubiger') : ()),
);
