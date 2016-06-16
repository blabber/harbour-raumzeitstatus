# Prevent brp-python-bytecompile from running
%define __os_install_post %{___build_post}

Summary: Displays status information about the RaumZeitLabor hackerspace
Name: harbour-raumzeitstatus
Version: 1.0.0
Release: 1
Source: %{name}-%{version}.tar.gz
BuildArch: noarch
URL: https://github.com/blabber/harbour-raumzeitstatus
License: Beerware
Group: Applications/System
Requires:   sailfishsilica-qt5 >= 0.10.9
Requires:   pyotherside-qml-plugin-python3-qt5 >= 1.4.0

%description
RaumZeitStatus displays status information about the RaumZeitLabor hackerspace
in Mannheim, Germany.

If you are not affiliated to RaumZeitLabor this application is probably useless
for you.

%prep
%setup -q

%build
# Nothing to do

%install

TARGET=%{buildroot}/%{_datadir}/%{name}
mkdir -p $TARGET
cp -rpv images $TARGET/
cp -rpv python $TARGET/
cp -rpv qml $TARGET/

TARGET=%{buildroot}/%{_datadir}/applications
mkdir -p $TARGET
cp -rpv %{name}.desktop $TARGET/

TARGET=%{buildroot}/%{_datadir}/icons/hicolor/86x86/apps/
mkdir -p $TARGET
cp -rpv icons/86x86/%{name}.png $TARGET/

TARGET=%{buildroot}/%{_datadir}/icons/hicolor/108x108/apps/
mkdir -p $TARGET
cp -rpv icons/108x108/%{name}.png $TARGET/

TARGET=%{buildroot}/%{_datadir}/icons/hicolor/128x128/apps/
mkdir -p $TARGET
cp -rpv icons/128x128/%{name}.png $TARGET/

TARGET=%{buildroot}/%{_datadir}/icons/hicolor/256x256/apps/
mkdir -p $TARGET
cp -rpv icons/256x256/%{name}.png $TARGET/

%files
%defattr(-,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
