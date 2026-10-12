/*
#----------------------------------------------------------------------------
# Description:
# This view provides static values for measurement calculations on measurement (cm and inch) and internal organisation level .
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     24.03.2024      Simeon Nikolaev          Update _be_fr
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_PERIODE
(
    periode_id
  , periode_desc_be
  , periode_desc_be_fr
  , periode_desc_bg 
  , periode_desc_cy
  , periode_desc_cz
  , periode_desc
  , periode_desc_dk 
  , periode_desc_ee 
  , periode_desc_es
  , periode_desc_fi
  , periode_desc_fr
  , periode_desc_gb
  , periode_desc_gr
  , periode_desc_hr 
  , periode_desc_hu
  , periode_desc_ie
  , periode_desc_it
  , periode_desc_lt
  , periode_desc_lv
  , periode_desc_nl
  , periode_desc_pl
  , periode_desc_pt
  , periode_desc_ro
  , periode_desc_rs
  , periode_desc_se
  , periode_desc_si
  , periode_desc_sk
  , periode_desc_us
  , periode_desc_ni
  , periode_desc_mt
  , periode_desc_cs
  , periode_from
  , periode_to
)
AS
SELECT periode_id
     , periode_desc_be
	 , periode_desc_be AS periode_desc_be_fr
     , periode_desc_bg 
     , periode_desc_cy
     , periode_desc_cz
     , periode_desc
     , periode_desc_dk 
     , periode_desc_ee 
     , periode_desc_es
     , periode_desc_fi
     , periode_desc_fr
     , periode_desc_gb
     , periode_desc_gr
     , periode_desc_hr 
     , periode_desc_hu
     , periode_desc_ie
     , periode_desc_it
     , periode_desc_lt
     , periode_desc_lv
     , periode_desc_nl
     , periode_desc_pl
     , periode_desc_pt
     , periode_desc_ro
     , periode_desc_rs
     , periode_desc_se
     , periode_desc_si
     , periode_desc_sk
     , periode_desc_us
     , periode_desc_ni
     , periode_desc_mt
     , periode_desc_cs
     , periode_from
     , periode_to
FROM FE_MSTR_TOOLBOX_SPIEGEL.t_spaceman_periode;