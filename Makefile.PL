use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Sub::Fallback',
    VERSION_FROM => 'lib/Sub/Fallback.pm',
    PREREQ_PM    => { Exporter => 0 },
    ($] >= 5.005 
      ? (ABSTRACT_FROM => 'lib/Sub/Fallback.pm') : ()
    ),
);
