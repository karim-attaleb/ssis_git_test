CREATE TABLE [IR].[Sjabloon] (
    [SjabloonID]  INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Content]     VARBINARY (MAX) NOT NULL,
    [SoftDeleted] BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]  ROWVERSION      NOT NULL,
    CONSTRAINT [PK_Sjabloon_SjabloonID] PRIMARY KEY CLUSTERED ([SjabloonID] ASC)
) TEXTIMAGE_ON [DataBin];

