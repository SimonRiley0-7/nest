export const MOCK_PROPERTIES = [
  {
    id: 'prop_1',
    title: 'Skyline Grand Eco-Residences',
    sellerRole: 'builder',
    sellerName: 'Apex Urban Developers',
    companyName: 'Apex Urban Developers Pvt Ltd',
    sellerContact: '+91 98765 43210',
    location: 'Whitefield Main Rd, Bangalore',
    city: 'Bangalore',
    price: 13500000, // 1.35 Cr
    priceFormatted: '₹1.35 Cr',
    areaSqFt: 1850,
    bhk: '3BHK',
    description: 'Luxury smart green 3BHK apartment with solar power grid, EV charging bays, rooftop infinity pool, and top IB international schools within 1.5 km.',
    images: [
      'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80'
    ],
    estimatedValuation: 14200000,
    projected5YrAppreciation: 42.5,
    suitabilityScore: 94,
    isFlashAd: true,
    discountTag: '5% Early Bird Discount before Nov 30',
    viewCount: 1420,
    leadCount: 88,
    bookmarkCount: 312,
    reactions: { likes: 210, inquiries: 88, saved: 312 },
    buildingAge: 'New Construction (2026)',
    surroundings: {
      schools: ['Greenwood High (1.2 km)', 'Oakridge Intl (2.0 km)'],
      hospitals: ['Manipal Hospital (1.5 km)', 'Columbia Asia (3.1 km)'],
      transport: ['Whitefield Metro Station (600m)', 'ORR Flyover (2.5 km)'],
      markets: ['Forum Value Mall (1.0 km)', 'Lidl Supermarket (400m)']
    },
    geologicalRisks: {
      seismicZone: 'Zone II (Low Risk)',
      floodRisk: 'Very Low (Elevated Plateau)',
      airQualityIndex: '42 AQI (Good)',
      groundwaterDepth: '140 ft (Stable Aquifer)'
    },
    builderUnitConfigs: [
      { bhk: '1BHK', areaSqFt: 750, price: 5800000, priceFormatted: '₹58 Lakhs', totalUnits: 12 },
      { bhk: '2BHK', areaSqFt: 1250, price: 9200000, priceFormatted: '₹92 Lakhs', totalUnits: 24 },
      { bhk: '3BHK', areaSqFt: 1850, price: 13500000, priceFormatted: '₹1.35 Cr', totalUnits: 16 }
    ],
    legalDocs: [
      { id: 'doc_1', title: 'RERA Registration Certificate', regNo: 'PRM/KA/RERA/1251/310/PR/260115', file: 'RERA_CERT_BGL_2026.pdf', verified: true },
      { id: 'doc_2', title: 'A-Khata Title Deed & Sanctioned Plan', regNo: 'BBMP/SAN/2025/8892', file: 'TITLE_DEED_APEX.pdf', verified: true },
      { id: 'doc_3', title: 'Encumbrance Certificate (30 Yrs)', regNo: 'EC-BGL-2026-9901', file: 'EC_CERTIFICATE_30YR.pdf', verified: true }
    ]
  },
  {
    id: 'prop_2',
    title: 'Greenwoods Private Luxury Villa',
    sellerRole: 'owner',
    sellerName: 'Rajesh Kumar (Property Owner)',
    companyName: null,
    sellerContact: '+91 91234 56789',
    location: 'Koregaon Park, Pune',
    city: 'Pune',
    price: 24000000, // 2.4 Cr
    priceFormatted: '₹2.40 Cr',
    areaSqFt: 3100,
    bhk: '4BHK',
    description: 'Independent owner listing. Fully renovated Mediterranean style villa with private lawn, solar rooftop grid, Italian marble flooring, and 2-car garage.',
    images: [
      'https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80'
    ],
    estimatedValuation: 25500000,
    projected5YrAppreciation: 38.0,
    suitabilityScore: 89,
    isFlashAd: false,
    discountTag: 'Direct Owner - Zero Brokerage Fee',
    viewCount: 610,
    leadCount: 29,
    bookmarkCount: 145,
    reactions: { likes: 89, inquiries: 29, saved: 145 },
    buildingAge: '3.5 Years Old',
    surroundings: {
      schools: ['St. Marys School (1.8 km)', 'Bishop School (2.4 km)'],
      hospitals: ['Ruby Hall Clinic (1.1 km)', 'Jehangir Hospital (2.0 km)'],
      transport: ['Pune Railway Station (3.5 km)', 'Airport Road (4.0 km)'],
      markets: ['Koregaon Park Plaza (800m)', 'Nature Basket (500m)']
    },
    geologicalRisks: {
      seismicZone: 'Zone III (Moderate Risk)',
      floodRisk: 'Low (Well-drained basalt terrain)',
      airQualityIndex: '38 AQI (Very Good)',
      groundwaterDepth: '90 ft (High Water Table)'
    },
    builderUnitConfigs: null,
    legalDocs: [
      { id: 'doc_4', title: '7/12 Revenue Extract & Mutation Entry', regNo: 'PMC/712/KP/4412', file: '712_EXTRACT_PUNE.pdf', verified: true },
      { id: 'doc_5', title: 'Municipal Corporation Occupancy Certificate (OC)', regNo: 'PMC-OC-2023-1102', file: 'NOC_MUNICIPAL.pdf', verified: true }
    ]
  },
  {
    id: 'prop_3',
    title: 'Horizon Heights Sea View 2BHK',
    sellerRole: 'builder',
    sellerName: 'Maritime Developers',
    companyName: 'Maritime Infra Projects Ltd',
    sellerContact: '+91 99887 76655',
    location: 'Worli Sea Face, Mumbai',
    city: 'Mumbai',
    price: 32000000, // 3.2 Cr
    priceFormatted: '₹3.20 Cr',
    areaSqFt: 1100,
    bhk: '2BHK',
    description: 'High-rise waterfront residences with direct panoramic views of Bandra-Worli Sea Link, automated home controls, and high-speed private elevators.',
    images: [
      'https://images.unsplash.com/photo-1567496898669-ee935f5f647a?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80'
    ],
    estimatedValuation: 33800000,
    projected5YrAppreciation: 49.0,
    suitabilityScore: 91,
    isFlashAd: true,
    discountTag: 'Save ₹5 Lakhs on Booking this Week',
    viewCount: 2890,
    leadCount: 142,
    bookmarkCount: 520,
    reactions: { likes: 410, inquiries: 142, saved: 520 },
    buildingAge: 'Under Construction (Possession Q4 2026)',
    surroundings: {
      schools: ['High Street International (2.1 km)'],
      hospitals: ['Lilavati Hospital (3.5 km)', 'Hinduja Hospital (2.8 km)'],
      transport: ['Worli Coastal Road Interchange (400m)', 'Monorail (1.2 km)'],
      markets: ['Phoenix Palladium (1.8 km)']
    },
    geologicalRisks: {
      seismicZone: 'Zone III (Moderate)',
      floodRisk: 'Moderate (Coastal Protection Wall Fitted)',
      airQualityIndex: '55 AQI (Moderate)',
      groundwaterDepth: 'Saline Coastal Substrata'
    },
    builderUnitConfigs: [
      { bhk: '2BHK', areaSqFt: 1100, price: 32000000, priceFormatted: '₹3.20 Cr', totalUnits: 30 },
      { bhk: '3BHK', areaSqFt: 1650, price: 48000000, priceFormatted: '₹4.80 Cr', totalUnits: 15 }
    ],
    legalDocs: [
      { id: 'doc_6', title: 'MahaRERA Registration Certificate', regNo: 'P51900028911', file: 'MAHARERA_MARITIME.pdf', verified: true },
      { id: 'doc_7', title: 'CRZ Coastal Regulation Clearance', regNo: 'CRZ/MCZMA/2025/77', file: 'CRZ_CLEARANCE_WORLI.pdf', verified: true }
    ]
  }
];
