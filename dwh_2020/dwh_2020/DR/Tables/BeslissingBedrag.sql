CREATE TABLE [DR].[BeslissingBedrag] (
    [BeslissingBedragID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BeslissingID]       INT             NOT NULL,
    [Bedrag]             DECIMAL (18, 2) NULL,
    [SubsidieTypeID]     NVARCHAR (15)   NULL,
    [SoftDeleted]        BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION      NOT NULL,
    CONSTRAINT [PK_BeslissingBedrag] PRIMARY KEY CLUSTERED ([BeslissingBedragID] ASC),
    CONSTRAINT [FK_BeslissingBedrag_Beslissing] FOREIGN KEY ([BeslissingID]) REFERENCES [DR].[Beslissing] ([BeslissingID])
);

