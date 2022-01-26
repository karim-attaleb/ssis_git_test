CREATE TABLE [FF].[IndieningAantal] (
    [IndieningAantalID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]           INT            NOT NULL,
    [IndieningAantalTypeID] NVARCHAR (15)  NOT NULL,
    [DiersoortID]           NVARCHAR (15)  NOT NULL,
    [Aantal]                INT            NULL,
    [Beschrijving]          NVARCHAR (800) NULL,
    [SoftDeleted]           BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningAantal] PRIMARY KEY CLUSTERED ([IndieningAantalID] ASC),
    CONSTRAINT [FK_IndieningAantal_Diersoort] FOREIGN KEY ([DiersoortID]) REFERENCES [FF].[Diersoort] ([DiersoortID]),
    CONSTRAINT [FK_IndieningAantal_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningAantal_IndieningAantalType] FOREIGN KEY ([IndieningAantalTypeID]) REFERENCES [FF].[IndieningAantalType] ([IndieningAantalTypeID])
);

