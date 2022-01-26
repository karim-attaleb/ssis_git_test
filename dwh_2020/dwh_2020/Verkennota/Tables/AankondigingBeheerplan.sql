CREATE TABLE [Verkennota].[AankondigingBeheerplan] (
    [AankondigingBeheerplanID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AankondigingBeheerplanTypeID] NVARCHAR (15)  NOT NULL,
    [IndieningID]                  INT            NOT NULL,
    [Description]                  NVARCHAR (MAX) NULL,
    [SoftDeleted]                  BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                   ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([AankondigingBeheerplanID] ASC),
    CONSTRAINT [FK_AankondigingBeheerplan_AankondigingBeheerplanType] FOREIGN KEY ([AankondigingBeheerplanTypeID]) REFERENCES [Verkennota].[AankondigingBeheerplanType] ([AankondigingBeheerplanTypeID]),
    CONSTRAINT [FK_AankondigingBeheerplan_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

