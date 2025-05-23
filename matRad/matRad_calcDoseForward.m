function resultGUI = matRad_calcDoseForward(ct,cst,stf,pln,w)
    % matRad forward dose calculation (no dij)
    % 
    % call
    %   resultGUI = matRad_calcDoseForward(ct,stf,pln,cst) %If weights stored in stf
    %   resultGUI = matRad_calcDoseForward(ct,stf,pln,cst,w)
    %
    % input
    %   ct:         ct cube
    %   cst:        matRad cst cell array
    %   stf:        matRad steering information struct
    %   pln:        matRad plan meta information struct
    %   w:          optional (if no weights available in stf): bixel weight
    %               vector
    %
    % output
    %   resultGUI:  matRad result struct
    %
    % References
    %   -
    %
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Copyright 2015 the matRad development team. 
    % 
    % This file is part of the matRad project. It is subject to the license 
    % terms in the LICENSE file found in the top-level directory of this 
    % distribution and at https://github.com/e0404/matRad/LICENSE.md. No part 
    % of the matRad project, including this file, may be copied, modified, 
    % propagated, or distributed except according to the terms contained in the 
    % LICENSE file.
    %
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    matRad_cfg = MatRad_Config.instance();
    
    %Deprecation warnings
    if ~isfield(stf,'machine')
        matRad_cfg.dispDeprecationWarning('stf should contain the machine name in the ''machine'' field since matRad 3. Manually adding ''%s'' from pln.',pln.machine);
        for i=1:numel(stf)
            stf(i).machine = pln.machine;
        end
    end
    
    engine = DoseEngines.matRad_DoseEngineBase.getEngineFromPln(pln);
    
    if nargin < 5
        resultGUI = engine.calcDoseForward(ct,cst,stf);
    else
        resultGUI = engine.calcDoseForward(ct,cst,stf,w);
    end
    
    end
    
    
    
    