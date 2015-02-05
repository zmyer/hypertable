#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
require 5.6.0;
use strict;
use warnings;
use Thrift;

package Hypertable::ThriftGen2::HqlResult;
use base qw(Class::Accessor);
Hypertable::ThriftGen2::HqlResult->mk_accessors( qw( results cells scanner mutator ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{results} = undef;
  $self->{cells} = undef;
  $self->{scanner} = undef;
  $self->{mutator} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{results}) {
      $self->{results} = $vals->{results};
    }
    if (defined $vals->{cells}) {
      $self->{cells} = $vals->{cells};
    }
    if (defined $vals->{scanner}) {
      $self->{scanner} = $vals->{scanner};
    }
    if (defined $vals->{mutator}) {
      $self->{mutator} = $vals->{mutator};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'HqlResult';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1) 
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^1$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size0 = 0;
          $self->{results} = [];
          my $_etype3 = 0;
          $xfer += $input->readListBegin(\$_etype3, \$_size0);
          for (my $_i4 = 0; $_i4 < $_size0; ++$_i4)
          {
            my $elem5 = undef;
            $xfer += $input->readString(\$elem5);
            push(@{$self->{results}},$elem5);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^2$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size6 = 0;
          $self->{cells} = [];
          my $_etype9 = 0;
          $xfer += $input->readListBegin(\$_etype9, \$_size6);
          for (my $_i10 = 0; $_i10 < $_size6; ++$_i10)
          {
            my $elem11 = undef;
            $elem11 = new Hypertable::ThriftGen::Cell();
            $xfer += $elem11->read($input);
            push(@{$self->{cells}},$elem11);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^3$/ && do{      if ($ftype == TType::I64) {
        $xfer += $input->readI64(\$self->{scanner});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^4$/ && do{      if ($ftype == TType::I64) {
        $xfer += $input->readI64(\$self->{mutator});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('HqlResult');
  if (defined $self->{results}) {
    $xfer += $output->writeFieldBegin('results', TType::LIST, 1);
    {
      $xfer += $output->writeListBegin(TType::STRING, scalar(@{$self->{results}}));
      {
        foreach my $iter12 (@{$self->{results}}) 
        {
          $xfer += $output->writeString($iter12);
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{cells}) {
    $xfer += $output->writeFieldBegin('cells', TType::LIST, 2);
    {
      $xfer += $output->writeListBegin(TType::STRUCT, scalar(@{$self->{cells}}));
      {
        foreach my $iter13 (@{$self->{cells}}) 
        {
          $xfer += ${iter13}->write($output);
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{scanner}) {
    $xfer += $output->writeFieldBegin('scanner', TType::I64, 3);
    $xfer += $output->writeI64($self->{scanner});
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{mutator}) {
    $xfer += $output->writeFieldBegin('mutator', TType::I64, 4);
    $xfer += $output->writeI64($self->{mutator});
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package Hypertable::ThriftGen2::HqlResult2;
use base qw(Class::Accessor);
Hypertable::ThriftGen2::HqlResult2->mk_accessors( qw( results cells scanner mutator ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{results} = undef;
  $self->{cells} = undef;
  $self->{scanner} = undef;
  $self->{mutator} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{results}) {
      $self->{results} = $vals->{results};
    }
    if (defined $vals->{cells}) {
      $self->{cells} = $vals->{cells};
    }
    if (defined $vals->{scanner}) {
      $self->{scanner} = $vals->{scanner};
    }
    if (defined $vals->{mutator}) {
      $self->{mutator} = $vals->{mutator};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'HqlResult2';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1) 
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^1$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size14 = 0;
          $self->{results} = [];
          my $_etype17 = 0;
          $xfer += $input->readListBegin(\$_etype17, \$_size14);
          for (my $_i18 = 0; $_i18 < $_size14; ++$_i18)
          {
            my $elem19 = undef;
            $xfer += $input->readString(\$elem19);
            push(@{$self->{results}},$elem19);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^2$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size20 = 0;
          $self->{cells} = [];
          my $_etype23 = 0;
          $xfer += $input->readListBegin(\$_etype23, \$_size20);
          for (my $_i24 = 0; $_i24 < $_size20; ++$_i24)
          {
            my $elem25 = undef;
            {
              my $_size26 = 0;
              $elem25 = [];
              my $_etype29 = 0;
              $xfer += $input->readListBegin(\$_etype29, \$_size26);
              for (my $_i30 = 0; $_i30 < $_size26; ++$_i30)
              {
                my $elem31 = undef;
                $xfer += $input->readString(\$elem31);
                push(@{$elem25},$elem31);
              }
              $xfer += $input->readListEnd();
            }
            push(@{$self->{cells}},$elem25);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^3$/ && do{      if ($ftype == TType::I64) {
        $xfer += $input->readI64(\$self->{scanner});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^4$/ && do{      if ($ftype == TType::I64) {
        $xfer += $input->readI64(\$self->{mutator});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('HqlResult2');
  if (defined $self->{results}) {
    $xfer += $output->writeFieldBegin('results', TType::LIST, 1);
    {
      $xfer += $output->writeListBegin(TType::STRING, scalar(@{$self->{results}}));
      {
        foreach my $iter32 (@{$self->{results}}) 
        {
          $xfer += $output->writeString($iter32);
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{cells}) {
    $xfer += $output->writeFieldBegin('cells', TType::LIST, 2);
    {
      $xfer += $output->writeListBegin(TType::LIST, scalar(@{$self->{cells}}));
      {
        foreach my $iter33 (@{$self->{cells}}) 
        {
          {
            $xfer += $output->writeListBegin(TType::STRING, scalar(@{${iter33}}));
            {
              foreach my $iter34 (@{${iter33}}) 
              {
                $xfer += $output->writeString($iter34);
              }
            }
            $xfer += $output->writeListEnd();
          }
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{scanner}) {
    $xfer += $output->writeFieldBegin('scanner', TType::I64, 3);
    $xfer += $output->writeI64($self->{scanner});
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{mutator}) {
    $xfer += $output->writeFieldBegin('mutator', TType::I64, 4);
    $xfer += $output->writeI64($self->{mutator});
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package Hypertable::ThriftGen2::HqlResultAsArrays;
use base qw(Class::Accessor);
Hypertable::ThriftGen2::HqlResultAsArrays->mk_accessors( qw( results cells scanner mutator ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{results} = undef;
  $self->{cells} = undef;
  $self->{scanner} = undef;
  $self->{mutator} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{results}) {
      $self->{results} = $vals->{results};
    }
    if (defined $vals->{cells}) {
      $self->{cells} = $vals->{cells};
    }
    if (defined $vals->{scanner}) {
      $self->{scanner} = $vals->{scanner};
    }
    if (defined $vals->{mutator}) {
      $self->{mutator} = $vals->{mutator};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'HqlResultAsArrays';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1) 
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^1$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size35 = 0;
          $self->{results} = [];
          my $_etype38 = 0;
          $xfer += $input->readListBegin(\$_etype38, \$_size35);
          for (my $_i39 = 0; $_i39 < $_size35; ++$_i39)
          {
            my $elem40 = undef;
            $xfer += $input->readString(\$elem40);
            push(@{$self->{results}},$elem40);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^2$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size41 = 0;
          $self->{cells} = [];
          my $_etype44 = 0;
          $xfer += $input->readListBegin(\$_etype44, \$_size41);
          for (my $_i45 = 0; $_i45 < $_size41; ++$_i45)
          {
            my $elem46 = undef;
            {
              my $_size47 = 0;
              $elem46 = [];
              my $_etype50 = 0;
              $xfer += $input->readListBegin(\$_etype50, \$_size47);
              for (my $_i51 = 0; $_i51 < $_size47; ++$_i51)
              {
                my $elem52 = undef;
                $xfer += $input->readString(\$elem52);
                push(@{$elem46},$elem52);
              }
              $xfer += $input->readListEnd();
            }
            push(@{$self->{cells}},$elem46);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^3$/ && do{      if ($ftype == TType::I64) {
        $xfer += $input->readI64(\$self->{scanner});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^4$/ && do{      if ($ftype == TType::I64) {
        $xfer += $input->readI64(\$self->{mutator});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('HqlResultAsArrays');
  if (defined $self->{results}) {
    $xfer += $output->writeFieldBegin('results', TType::LIST, 1);
    {
      $xfer += $output->writeListBegin(TType::STRING, scalar(@{$self->{results}}));
      {
        foreach my $iter53 (@{$self->{results}}) 
        {
          $xfer += $output->writeString($iter53);
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{cells}) {
    $xfer += $output->writeFieldBegin('cells', TType::LIST, 2);
    {
      $xfer += $output->writeListBegin(TType::LIST, scalar(@{$self->{cells}}));
      {
        foreach my $iter54 (@{$self->{cells}}) 
        {
          {
            $xfer += $output->writeListBegin(TType::STRING, scalar(@{${iter54}}));
            {
              foreach my $iter55 (@{${iter54}}) 
              {
                $xfer += $output->writeString($iter55);
              }
            }
            $xfer += $output->writeListEnd();
          }
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{scanner}) {
    $xfer += $output->writeFieldBegin('scanner', TType::I64, 3);
    $xfer += $output->writeI64($self->{scanner});
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{mutator}) {
    $xfer += $output->writeFieldBegin('mutator', TType::I64, 4);
    $xfer += $output->writeI64($self->{mutator});
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

1;
