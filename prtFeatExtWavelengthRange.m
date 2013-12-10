classdef prtFeatExtWavelengthRange < prtAction
    
    properties (SetAccess=private)
        name = 'Wavelength Range' % Principal Component Analysis
        nameAbbreviation = 'waveRange'  % PCA
    end
    
    properties
        wavelengthRange
        fn = @(x)max(x,[],2);
    end
    
    properties (SetAccess = protected)
        isSupervised = false;  % False
        isCrossValidateValid = true; % True
    end
    
    properties (SetAccess=private)
        
    end
    
    methods
        
          % Allow for string, value pairs
        function self = prtFeatExtWavelengthRange(varargin)
            self.isTrained = true;
            self = prtUtilAssignStringValuePairs(self,varargin{:});
        end
    end
    
    methods (Access = protected, Hidden = true)
        
        function self = trainAction(self,~)
            
        end
        
        function dataSet = runAction(self,dataSet)
            
            if ~isfield(dataSet.userData,'wavelengths')
                error('prtFeatExtWavelengthRange requires userData.wavelengths');
            end
            w = dataSet.userData.wavelengths;
            inside = w > self.wavelengthRange(1) & w < self.wavelengthRange(2);
            x = dataSet.getX;
            features = self.fn(x(:,inside));
            dataSet = dataSet.setX(features);
        end
        
        function xOut = runActionFast(self,xIn)
            error('requires wavelengths');
        end
        
    end
end