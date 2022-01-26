CREATE TABLE [FF].[IndieningSchade] (
    [IndieningSchadeID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]           INT            NOT NULL,
    [IndieningSchadeTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]          NVARCHAR (MAX) NULL,
    [SoftDeleted]           BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([IndieningSchadeID] ASC),
    CONSTRAINT [FK_IndieningSchade_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningSchade_IndieningSchadeType] FOREIGN KEY ([IndieningSchadeTypeID]) REFERENCES [FF].[IndieningSchadeType] ([IndieningSchadeTypeID])
);

