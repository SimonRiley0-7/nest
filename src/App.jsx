import React, { useState } from 'react';
import Header from './components/Header';
import FlashAdCarousel from './components/FlashAdCarousel';
import PropertyCard from './components/PropertyCard';
import AIValuationModal from './components/AIValuationModal';
import AICompareModal from './components/AICompareModal';
import AIAssistantChat from './components/AIAssistantChat';
import CallMaskingModal from './components/CallMaskingModal';
import WatermarkDocViewer from './components/WatermarkDocViewer';
import OwnerOnboardingWizard from './components/OwnerOnboardingWizard';
import BuilderOnboardingWizard from './components/BuilderOnboardingWizard';
import BuyerOnboardingWizard from './components/BuyerOnboardingWizard';
import BuilderAnalytics from './components/BuilderAnalytics';
import { MOCK_PROPERTIES } from './data/mockData';
import { Search, SlidersHorizontal, MapPin, Filter, Sparkles, Building2, User, PhoneCall, PlusCircle, CheckCircle } from 'lucide-react';

export default function App() {
  const [activeRole, setActiveRole] = useState('buyer'); // buyer | owner | builder
  const [properties, setProperties] = useState(MOCK_PROPERTIES);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCity, setSelectedCity] = useState('All Cities');
  const [selectedBhk, setSelectedBhk] = useState('All');
  
  // Modals state
  const [valuationProperty, setValuationProperty] = useState(null);
  const [callMaskingProperty, setCallMaskingProperty] = useState(null);
  const [docsProperty, setDocsProperty] = useState(null);
  const [compareList, setCompareList] = useState([]);
  const [showCompareModal, setShowCompareModal] = useState(false);
  const [showAssistant, setShowAssistant] = useState(false);
  const [activePropertyForAssistant, setActivePropertyForAssistant] = useState(null);

  // Onboarding Wizards
  const [showOwnerWizard, setShowOwnerWizard] = useState(false);
  const [showBuilderWizard, setShowBuilderWizard] = useState(false);
  const [showBuyerWizard, setShowBuyerWizard] = useState(false);

  // Filter properties
  const filteredProperties = properties.filter((p) => {
    if (selectedCity !== 'All Cities' && p.city !== selectedCity) return false;
    if (selectedBhk !== 'All' && p.bhk !== selectedBhk) return false;
    if (searchQuery.trim() !== '') {
      const q = searchQuery.toLowerCase();
      return (
        p.title.toLowerCase().includes(q) ||
        p.location.toLowerCase().includes(q) ||
        p.description.toLowerCase().includes(q) ||
        p.bhk.toLowerCase().includes(q)
      );
    }
    return true;
  });

  const flashAds = properties.filter((p) => p.isFlashAd);

  const toggleCompare = (property) => {
    if (compareList.some((p) => p.id === property.id)) {
      setCompareList(compareList.filter((p) => p.id !== property.id));
    } else {
      if (compareList.length >= 3) {
        alert('You can compare up to 3 properties at a time.');
        return;
      }
      setCompareList([...compareList, property]);
    }
  };

  const handleOwnerOnboardComplete = (data) => {
    setShowOwnerWizard(false);
    const newProp = {
      id: `prop_owner_${Date.now()}`,
      title: `${data.ownershipDuration} Owner Property in ${data.location}`,
      sellerRole: 'owner',
      sellerName: data.name,
      sellerContact: data.phone,
      location: data.location,
      city: 'Pune',
      price: Number(data.sellingPrice),
      priceFormatted: `₹${(Number(data.sellingPrice) / 10000000).toFixed(2)} Cr`,
      areaSqFt: 2200,
      bhk: '3BHK',
      description: `Owner listing. Building age: ${data.buildingAge}. Nearby: ${data.surroundings}`,
      images: ['https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&w=800&q=80'],
      estimatedValuation: Number(data.sellingPrice) * 1.05,
      projected5YrAppreciation: 36.0,
      suitabilityScore: 92,
      isFlashAd: false,
      discountTag: 'Direct Owner - Zero Brokerage',
      viewCount: 1,
      leadCount: 0,
      bookmarkCount: 0,
      reactions: { likes: 0, inquiries: 0, saved: 0 },
      geologicalRisks: {
        seismicZone: 'Zone II (Low)',
        floodRisk: 'Low',
        airQualityIndex: '40 AQI',
        groundwaterDepth: '100 ft'
      },
      legalDocs: [
        { id: 'doc_new_1', title: '7/12 Extract', regNo: 'PMC/NEW/2026', file: '712_new.pdf', verified: true }
      ]
    };
    setProperties([newProp, ...properties]);
    alert('🎉 Owner Property Listed Successfully!');
  };

  const handleBuilderOnboardComplete = (data) => {
    setShowBuilderWizard(false);
    const newProp = {
      id: `prop_builder_${Date.now()}`,
      title: `${data.schemes}`,
      sellerRole: 'builder',
      sellerName: data.companyName,
      companyName: data.companyName,
      sellerContact: data.contactDetails,
      location: data.location,
      city: 'Bangalore',
      price: Number(data.unitConfigs[0].price),
      priceFormatted: `₹${(Number(data.unitConfigs[0].price) / 10000000).toFixed(2)} Cr`,
      areaSqFt: Number(data.unitConfigs[0].areaSqFt),
      bhk: data.unitConfigs[0].bhk,
      description: `New Developer Project by ${data.companyName}. RERA: ${data.reraNo}`,
      images: ['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=800&q=80'],
      estimatedValuation: Number(data.unitConfigs[0].price) * 1.08,
      projected5YrAppreciation: 44.0,
      suitabilityScore: 95,
      isFlashAd: true,
      discountTag: 'Exclusive Builder Launch Pricing',
      viewCount: 1,
      leadCount: 0,
      bookmarkCount: 0,
      reactions: { likes: 0, inquiries: 0, saved: 0 },
      geologicalRisks: {
        seismicZone: 'Zone II (Low)',
        floodRisk: 'Very Low',
        airQualityIndex: '42 AQI',
        groundwaterDepth: '120 ft'
      },
      builderUnitConfigs: data.unitConfigs.map((u) => ({
        bhk: u.bhk,
        areaSqFt: Number(u.areaSqFt),
        price: Number(u.price),
        priceFormatted: `₹${(Number(u.price) / 10000000).toFixed(2)} Cr`,
        totalUnits: 20
      })),
      legalDocs: [
        { id: 'doc_b_1', title: 'RERA Certificate', regNo: data.reraNo, file: 'RERA_cert.pdf', verified: true }
      ]
    };
    setProperties([newProp, ...properties]);
    alert('🚀 Builder Project Scheme Published Successfully!');
  };

  return (
    <div className="min-h-screen flex flex-col bg-slate-950 text-slate-100">
      {/* Top Header with Role Switching */}
      <Header
        activeRole={activeRole}
        setRole={setActiveRole}
        onOpenAssistant={() => setShowAssistant(true)}
        onOpenCompare={() => setShowCompareModal(true)}
      />

      <main className="flex-1 max-w-7xl w-full mx-auto p-4 md:p-6 space-y-6">
        {/* Role Specific Action Banners */}
        {activeRole === 'owner' && (
          <div className="glass-card p-5 rounded-2xl border border-emerald-500/30 flex flex-col md:flex-row items-center justify-between gap-4">
            <div>
              <div className="flex items-center gap-2">
                <span className="px-2 py-0.5 rounded-full bg-emerald-500/20 text-emerald-300 text-xs font-bold border border-emerald-500/30">
                  Owner Dashboard
                </span>
              </div>
              <h2 className="text-xl font-bold text-white mt-1">List Your Individual Property</h2>
              <p className="text-xs text-slate-300">Complete our 8-step owner onboarding flow with encrypted document protection.</p>
            </div>
            <button
              onClick={() => setShowOwnerWizard(true)}
              className="px-5 py-2.5 rounded-xl bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white font-bold text-xs shadow-lg flex items-center gap-2"
            >
              <PlusCircle className="w-4 h-4" /> Start Owner Listing Flow
            </button>
          </div>
        )}

        {activeRole === 'builder' && (
          <BuilderAnalytics
            properties={properties}
            onStartOnboarding={() => setShowBuilderWizard(true)}
          />
        )}

        {/* Buyer View */}
        {activeRole === 'buyer' && (
          <>
            {/* Flash Ads Carousel */}
            <FlashAdCarousel
              ads={flashAds}
              onSelectAd={(ad) => {
                setValuationProperty(ad);
              }}
            />

            {/* Search & Filter Bar */}
            <div className="glass-card p-4 rounded-2xl border border-slate-800 space-y-3">
              <div className="flex flex-col md:flex-row items-center gap-3">
                {/* Natural Language AI Search */}
                <div className="relative flex-1 w-full">
                  <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
                  <input
                    type="text"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder='Try natural language AI search: "3BHK under 1.5 Cr in Whitefield near schools"'
                    className="w-full bg-slate-900 border border-slate-800 rounded-xl pl-10 pr-4 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-indigo-500"
                  />
                </div>

                {/* City & BHK Dropdowns */}
                <div className="flex items-center gap-2 w-full md:w-auto">
                  <select
                    value={selectedCity}
                    onChange={(e) => setSelectedCity(e.target.value)}
                    className="bg-slate-900 border border-slate-800 rounded-xl px-3 py-2.5 text-xs text-white focus:outline-none focus:border-indigo-500"
                  >
                    <option>All Cities</option>
                    <option>Bangalore</option>
                    <option>Pune</option>
                    <option>Mumbai</option>
                  </select>

                  <select
                    value={selectedBhk}
                    onChange={(e) => setSelectedBhk(e.target.value)}
                    className="bg-slate-900 border border-slate-800 rounded-xl px-3 py-2.5 text-xs text-white focus:outline-none focus:border-indigo-500"
                  >
                    <option>All BHK</option>
                    <option>2BHK</option>
                    <option>3BHK</option>
                    <option>4BHK</option>
                  </select>

                  <button
                    onClick={() => setShowBuyerWizard(true)}
                    className="px-3 py-2.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-indigo-300 text-xs font-semibold border border-slate-700 transition-colors flex items-center gap-1.5"
                  >
                    <SlidersHorizontal className="w-3.5 h-3.5" />
                    <span>Buyer Wizard</span>
                  </button>
                </div>
              </div>

              {/* Compare Tray Bar */}
              {compareList.length > 0 && (
                <div className="bg-indigo-950/80 p-2.5 rounded-xl border border-indigo-500/40 flex items-center justify-between text-xs animate-fadeIn">
                  <div className="flex items-center gap-2">
                    <Sparkles className="w-4 h-4 text-indigo-400" />
                    <span className="font-bold text-white">Ask AI Comparison Tray ({compareList.length}/3 selected)</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => setCompareList([])}
                      className="text-slate-400 hover:text-white text-[11px]"
                    >
                      Clear
                    </button>
                    <button
                      onClick={() => setShowCompareModal(true)}
                      className="px-3 py-1 rounded-lg bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-md"
                    >
                      Run AI Comparison
                    </button>
                  </div>
                </div>
              )}
            </div>

            {/* Marketplace Listings Grid */}
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <h2 className="text-lg font-bold text-white tracking-tight">
                  Verified Real Estate Listings ({filteredProperties.length})
                </h2>
                <span className="text-xs text-slate-400">Sorted by AI Unified Match Score</span>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {filteredProperties.map((property) => (
                  <PropertyCard
                    key={property.id}
                    property={property}
                    onOpenValuation={(p) => setValuationProperty(p)}
                    onOpenCallMasking={(p) => setCallMaskingProperty(p)}
                    onOpenDocs={(p) => setDocsProperty(p)}
                    onToggleCompare={toggleCompare}
                    isCompared={compareList.some((c) => c.id === property.id)}
                  />
                ))}
              </div>
            </div>
          </>
        )}
      </main>

      {/* Modals & Dialogs */}
      {valuationProperty && (
        <AIValuationModal
          property={valuationProperty}
          onClose={() => setValuationProperty(null)}
        />
      )}

      {showCompareModal && (
        <AICompareModal
          properties={compareList.length > 0 ? compareList : properties.slice(0, 2)}
          onClose={() => setShowCompareModal(false)}
        />
      )}

      {callMaskingProperty && (
        <CallMaskingModal
          property={callMaskingProperty}
          onClose={() => setCallMaskingProperty(null)}
        />
      )}

      {docsProperty && (
        <WatermarkDocViewer
          property={docsProperty}
          onClose={() => setDocsProperty(null)}
        />
      )}

      {showOwnerWizard && (
        <OwnerOnboardingWizard
          onClose={() => setShowOwnerWizard(false)}
          onComplete={handleOwnerOnboardComplete}
        />
      )}

      {showBuilderWizard && (
        <BuilderOnboardingWizard
          onClose={() => setShowBuilderWizard(false)}
          onComplete={handleBuilderOnboardComplete}
        />
      )}

      {showBuyerWizard && (
        <BuyerOnboardingWizard
          onClose={() => setShowBuyerWizard(false)}
          onComplete={() => setShowBuyerWizard(false)}
        />
      )}

      {showAssistant && (
        <AIAssistantChat
          onClose={() => setShowAssistant(false)}
          activeProperty={valuationProperty || properties[0]}
        />
      )}
    </div>
  );
}
