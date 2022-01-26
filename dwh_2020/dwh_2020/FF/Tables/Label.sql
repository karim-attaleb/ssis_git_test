CREATE TABLE [FF].[Label] (
    [LabelID]           INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LabelStatusID]     NVARCHAR (15) NOT NULL,
    [DiersoortID]       NVARCHAR (15) NOT NULL,
    [IndieningPartijID] INT           NOT NULL,
    [Jaartal]           SMALLINT      NOT NULL,
    [Volgnummer]        INT           NOT NULL,
    [SoftDeleted]       BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION    NOT NULL,
    CONSTRAINT [PK_Label] PRIMARY KEY CLUSTERED ([LabelID] ASC),
    CONSTRAINT [FK_Label_Diersoort] FOREIGN KEY ([DiersoortID]) REFERENCES [FF].[Diersoort] ([DiersoortID]),
    CONSTRAINT [FK_Label_LabelStatus] FOREIGN KEY ([LabelStatusID]) REFERENCES [FF].[LabelStatus] ([LabelStatusID]),
    CONSTRAINT [FK_Label_Partij] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID])
);

