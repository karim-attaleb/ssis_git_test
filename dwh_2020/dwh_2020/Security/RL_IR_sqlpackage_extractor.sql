CREATE ROLE [RL_IR_sqlpackage_extractor]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [RL_IR_sqlpackage_extractor] ADD MEMBER [sqlpackage_extractor];

