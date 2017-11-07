module GreenButtonData
  module Enumerations
    PHASE_CODE = {
      0 => :none,
      16 => :n,
      17 => :n_g,
      32 => :c,
      33 => :c_n,
      40 => :c_av,
      41 => :ca_n,
      64 => :b,
      65 => :b_n,
      66 => :b_c,
      72 => :b_av,
      97 => :b_c_n,  # TODO: Check with GB XML schema maintainers? https://github.com/energyos/OpenESPI-Common-java/blob/master/etc/espiDerived.xsd
      128 => :a,
      129 => :a_n,
      132 => :a_b,
      136 => :a_to_av,
      193 => :a_b_n,
      224 => :a_b_c,
      225 => :a_b_c_n,
      272 => :s2_n,
      512 => :s1,
      528 => :s1_n,
      768 => :s1_2,
      769 => :s12_n,
      784 => :s1_2_n
    }
  end
end
