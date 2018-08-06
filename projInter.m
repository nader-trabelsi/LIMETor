function varargout = projInter(varargin)
% PROJINTER MATLAB code for projInter.fig
%      PROJINTER, by itself, creates a new PROJINTER or raises the existing
%      singleton*.
%
%      H = PROJINTER returns the handle to a new PROJINTER or the handle to
%      the existing singleton*.
%
%      PROJINTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJINTER.M with the given input arguments.
%
%      PROJINTER('Property','Value',...) creates a new PROJINTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before projInter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to projInter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help projInter

% Last Modified by GUIDE v2.5 18-Apr-2017 20:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @projInter_OpeningFcn, ...
    'gui_OutputFcn',  @projInter_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before projInter is made visible.
function projInter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to projInter (see VARARGIN)

% Choose default command line output for projInter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes projInter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = projInter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in reinBut.
function reinBut_Callback(hObject, eventdata, handles)
% hObject    handle to reinBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arrayfun(@cla,findall(0,'type','axes'));
if isappdata(handles.figure1,'imgEdit')==1
    rmappdata(handles.figure1,'imgEdit');
    rmappdata(handles.figure1,'imgMat');
end


% --- Executes on button press in quitBut.
function quitBut_Callback(hObject, eventdata, handles)
% hObject    handle to quitBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.figure1);


% --- Executes on button press in ouvBut.
function ouvBut_Callback(hObject, eventdata, handles)
% hObject    handle to ouvBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[File_Name, Path_Name] = uigetfile('.\demo\*.*');
if isequal(File_Name,0)~=1
    arrayfun(@cla,findall(0,'type','axes'));
    if isappdata(handles.figure1,'imgEdit')==1
        rmappdata(handles.figure1,'imgEdit');
        rmappdata(handles.figure1,'imgMat');
    end
    axes(handles.imgPlace);
    imgChargePath = strcat(Path_Name, File_Name);
    imgCharge= imread(imgChargePath);
    imshow(imgCharge);
    setappdata(handles.figure1,'imgMat',imgCharge);
    if(size(imgCharge,3)~=3)
        axes(handles.hist1NBaxe);
        imhist(imgCharge);
    end
    if(size(imgCharge,3)==3)
        axes(handles.hist1Raxe);
        imhist(imgCharge(:,:,1));
        axes(handles.hist1Gaxe);
        imhist(imgCharge(:,:,2));
        axes(handles.hist1Baxe);
        imhist(imgCharge(:,:,3));
    end
    
end


% --- Executes on button press in SauBut.
function SauBut_Callback(hObject, eventdata, handles)
% hObject    handle to SauBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isappdata(handles.figure1,'imgEdit')==1
    imgEnreg=getappdata(handles.figure1,'imgEdit');
    [filename, foldername] = uiputfile({'*.jpg';'*.jpeg';'*.png';'*.tiff';'*.tif';'*.*'},'Sauvgarder l''image éditée');
    if isequal(filename,0)~=1
        complete_name = fullfile(foldername, filename);
        imwrite(imgEnreg, complete_name);
    end
else
    warndlg('Avant de procéder à la sauvegarde, veuillez tout d''abord éditer l''image chargée','Sauvegarde impossible!')
end


% --- Executes on button press in contBut.
function contBut_Callback(hObject, eventdata, handles)
% hObject    handle to contBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        if not(islogical(imgEntre))
            
            if(size(imgEntre,3)~=3)
                imgEntre=egaliserHisto(imgEntre);
                axes(handles.hist2NBaxe);
                imhist(imgEntre);
            end
            if(size(imgEntre,3)==3)
                imgEntre=histeq(imgEntre);
                axes(handles.hist2Raxe);
                imhist(imgEntre(:,:,1));
                axes(handles.hist2Gaxe);
                imhist(imgEntre(:,:,2));
                axes(handles.hist2Baxe);
                imhist(imgEntre(:,:,3));
            end
        end
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    if not(islogical(imgEntre))
        imgEntre=histeq(imgEntre);
        if(size(imgEntre,3)~=3)
            axes(handles.hist2NBaxe);
            imhist(imgEntre);
        end
        if(size(imgEntre,3)==3)
            axes(handles.hist2Raxe);
            imhist(imgEntre(:,:,1));
            axes(handles.hist2Gaxe);
            imhist(imgEntre(:,:,2));
            axes(handles.hist2Baxe);
            imhist(imgEntre(:,:,3));
        end
    end
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end


% --- Executes on button press in binBut.
function binBut_Callback(hObject, eventdata, handles)
% hObject    handle to binBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        
        if(size(imgEntre,3)~=3)
            if not(islogical(imgEntre))
                imgEntre=binariser(imgEntre);
            end
            setappdata(handles.figure1,'imgEdit',imgEntre);
            axes(handles.imgAxes2);
            imshow(imgEntre);
            axes(handles.hist2NBaxe);
            imhist(imgEntre);
        end
        if(size(imgEntre,3)==3)
            imgEntre=binariser(imgEntre);
            setappdata(handles.figure1,'imgEdit',imgEntre);
            axes(handles.imgAxes2);
            imshow(imgEntre);
            axes(handles.hist2NBaxe);
            imhist(imgEntre);
        end
        
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    cla(handles.hist2Raxe);
    cla(handles.hist2Gaxe);
    cla(handles.hist2Baxe);
    if(size(imgEntre,3)~=3)
        if not(islogical(imgEntre))
            imgEntre=binariser(imgEntre);
        end
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
        axes(handles.hist2NBaxe);
        imhist(imgEntre);
    end
    if(size(imgEntre,3)==3)
        imgEntre=binariser(imgEntre);
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
        axes(handles.hist2NBaxe);
        imhist(imgEntre);
    end
    
end

% --- Executes on button press in roteBut.
function roteBut_Callback(hObject, eventdata, handles)
% hObject    handle to roteBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        imgEntre=imrotate(imgEntre,90);
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    imgEntre=imrotate(imgEntre,90);
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end



% --- Executes on button press in rot1But.
function rot1But_Callback(hObject, eventdata, handles)
% hObject    handle to rot1But (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        imgEntre=imrotate(imgEntre,-90);
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    imgEntre=imrotate(imgEntre,-90);
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end


% --- Executes on button press in mirBut.
function mirBut_Callback(hObject, eventdata, handles)
% hObject    handle to mirBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        imgEntre=myFlip(imgEntre,2);
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    imgEntre=myFlip(imgEntre,2);
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end


% --- Executes on button press in flipBut.
function flipBut_Callback(hObject, eventdata, handles)
% hObject    handle to flipBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        imgEntre=myFlip(imgEntre,1);
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    imgEntre=myFlip(imgEntre,1);
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end


% --- Executes on button press in symBut.
function symBut_Callback(hObject, eventdata, handles)
% hObject    handle to symBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        imgEntre=myFlip(imgEntre,1);
        imgEntre=myFlip(imgEntre,2);
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    imgEntre=myFlip(imgEntre,1);
    imgEntre=myFlip(imgEntre,2);
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end


% --- Executes on button press in satBut.
function satBut_Callback(hObject, eventdata, handles)
% hObject    handle to satBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isappdata(handles.figure1,'imgEdit')==0
    if isappdata(handles.figure1,'imgMat')==1
        imgEntre=getappdata(handles.figure1,'imgMat');
        if not(islogical(imgEntre))
            if(size(imgEntre,3)==3)
                HSV = rgb2hsv(imgEntre);
                HSV(:, :, 2) = HSV(:, :, 2) + 0.05;
                HSV(HSV > 1) = 1;
                imgEntre = hsv2rgb(HSV);
                axes(handles.hist2Raxe);
                imhist(imgEntre(:,:,1));
                axes(handles.hist2Gaxe);
                imhist(imgEntre(:,:,2));
                axes(handles.hist2Baxe);
                imhist(imgEntre(:,:,3));
            end
        end
        setappdata(handles.figure1,'imgEdit',imgEntre);
        axes(handles.imgAxes2);
        imshow(imgEntre);
    end
else
    imgEntre=getappdata(handles.figure1,'imgEdit');
    if not(islogical(imgEntre))
        if(size(imgEntre,3)==3)
            HSV = rgb2hsv(imgEntre);
            HSV(:, :, 2) = HSV(:, :, 2) + 0.05;
            HSV(HSV > 1) = 1;
            imgEntre = hsv2rgb(HSV);
            axes(handles.hist2Raxe);
            imhist(imgEntre(:,:,1));
            axes(handles.hist2Gaxe);
            imhist(imgEntre(:,:,2));
            axes(handles.hist2Baxe);
            imhist(imgEntre(:,:,3));
        end
    end
    setappdata(handles.figure1,'imgEdit',imgEntre);
    axes(handles.imgAxes2);
    imshow(imgEntre);
end
